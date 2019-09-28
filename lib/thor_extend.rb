require 'yaml'
require 'json'
require 'pry'

module ThorActionsExtend
  include Thor::Actions

  CONFIG = JSON.parse(
      JSON.dump(YAML.load_file("#{File.dirname(__FILE__)}/config.yml")),
      symbolize_names: true
    )
  def run(options)
    @template_type = template_type
    @options = options
    @config = CONFIG[@template_type]
    self.class.source_root(template_folder(@template_type.to_s))

    fetch_template_variables
    render_templates
  end

  private

  def render_template(path)
    template path, "#{@output_folder}/#{path.gsub('.erb', '')}"
  end

  def template_folder(template_type)
    @options[:template_folder] || "#{File.dirname(__FILE__)}/../templates/#{template_type}"
  end

  def ask_with_options(option, limited_to = nil)
    return @options[option] if @options[option]

    limited_to = @config[:defaults][option] if default.nil?
    ask(@config[:questions][option], limited_to: limited_to)
  end

  def ask_with_default(option, default = nil)
    return @options[option] unless @options[option].nil?

    default = @config[:defaults][option] if default.nil?
    result = ask(@config[:questions][option])

    result == '' ? default : result
  end

  def ask_with_default_boolean(option)
    return @options[option] unless @options[option].nil?

    result = ask(@config[:questions][option])
    default = @config[:defaults][option] if default.nil?
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
