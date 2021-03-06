# frozen_string_literal: true

require 'yaml'
require 'json'

module ThorActionsExtend
  include Thor::Actions

  CONFIG = JSON.parse(
    JSON.dump(YAML.load_file("#{File.dirname(__FILE__)}/config.yml")),
    symbolize_names: true
  )

  def run(options, template_type)
    @template_type = template_type
    @options = options
    @output_folder = options['output_folder']
    @config = CONFIG[@template_type]
    self.class.source_root(template_type_path)

    fetch_template_variables
  end

  def fetch_template_variables
    @config[:questions].each do |question|
      default = question[:default]
      option = question[:option]
      title = question[:title]
      type = question[:type]

      if @options[option] || @options[option] == false
        instance_variable_set("@#{option}", @options[option])
        next
      end

      case type
      when 'with_default'
        instance_variable_set("@#{option}", default)
      when 'ask_with_default'
        result = ask(title)
        result == '' ? default : result

        instance_variable_set("@#{option}", result)
      when 'ask_with_default_boolean'
        result = ask(title)
        result = default if result == ''
        result = %w[yes y true].include?(result) ? true : false

        instance_variable_set("@#{option}", result)
      when 'ask_with_options'
        instance_variable_set("@#{option}", ask(title, limited_to: question[:ask_options]))
      else
        raise "Invalid question type: #{type}"
      end
    end
  end

  private

  def template_folder
    @options[:template_folder] || "#{File.dirname(__FILE__)}/../templates"
  end

  def template_type_path
    "#{template_folder}/#{@template_type}"
  end

  def render_all
    all_file_paths.each do |file_name|
      template file_name, "#{@output_folder}/#{file_name.gsub('.erb', '')}"
    end
  end

  def all_file_paths
    Dir.glob("#{template_type_path}/**/{*,.?*}")
      .reject { |x| File.directory?(x) }
      .map { |file_path| file_path.gsub("#{template_type_path}/", '') }
  end

  def render_template!(template_file)
    result = ERB.new(File.read("#{template_type_path}/#{template_file}")).result(binding)
    File.write("#{@output_folder}/#{template_file.gsub('.erb', '')}", result)
  end

  def append_or_create(file_path, file_content)
    if File.exist?(file_path)
      append_to_file file_path, file_content
    else
      create_file file_path, file_content
    end
  end
end
