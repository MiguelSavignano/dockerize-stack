require 'yaml'
require 'json'
require 'pry'

module ThorActionsExtend
  include Thor::Actions

  CONFIG = JSON.parse(
    JSON.dump(YAML.load_file("#{File.dirname(__FILE__)}/config.yml")),
    symbolize_names: true
  )

  def run(options, template_type)
    @template_type = template_type
    @options = options
    @output_folder = options[:output_folder]
    @config = CONFIG[@template_type]
    self.class.source_root(template_folder)

    fetch_template_variables
  end

  def fetch_template_variables
    @config[:questions].each do |question|
      default = question[:default]
      option = question[:option]
      title = question[:title]
      type = question[:type]

      case type
      when 'with_default'
        return default if @options[option].nil?

        @options[option]
      when 'ask_with_default'
        return @options[option] unless @options[option].nil?

        result = ask(title)
        result == '' ? default : result
      when 'ask_with_default_boolean'
        ask_with_default_boolean(question)
      when 'ask_with_options'
        return @options[option] if @options[option]

        instance_variable_set("@#{option}".to_sym, ask(title, limited_to: question[:ask_options]))
      else
        raise "Invalid question type: #{type}"
      end
    end
  end

  private

  def render_template(template_file)
    result = ERB.new(File.read("#{template_folder}/#{template_file}")).result(binding)
    File.write("#{@output_folder}/#{template_file.gsub('.erb', '')}", result)
  end

  def template_folder
    @options[:template_folder] || "#{File.dirname(__FILE__)}/../templates/#{@template_type}"
  end

  def render_template(path, target_path = path)
    template path, "#{@output_folder}/#{target_path.gsub('.erb', '')}"
  end

  def with_default(option)
    return @config[:defaults][option] if @options[option].nil?

    @options[option]
  end

  def ask_with_default(option, default = nil)
    return @options[option] unless @options[option].nil?

    default = @config[:defaults][option] if default.nil?
    result = ask(@config[:questions][option])

    result == '' ? default : result
  end

  def ask_with_options(option, limited_to = nil)
    return @options[option] if @options[option]

    limited_to = @config[:defaults][option] if limited_to.nil?
    ask(@config[:questions][option], limited_to: limited_to)
  end

  def ask_with_default_boolean(option:, title:, default:, type:)
    return option unless option.nil?

    result = ask(title)
    return default if result == ''

    %w[yes y true].include?(result) ? true : false
  end

  def append_or_create(file_path, file_content)
    if File.exist?(file_path)
      append_to_file file_path, file_content
    else
      create_file file_path, file_content
    end
  end
end
