require 'yaml'
require 'json'

module ThorActionsExtend
  include Thor::Actions

  CONFIG = JSON.parse(
      JSON.dump(YAML.load_file("#{File.dirname(__FILE__)}/config.yml")),
      symbolize_names: true
    )

  private

  def render_template(path)
    template path, "#{@output_folder}/#{path.gsub('.erb', '')}"
  end

  def template_folder(template_type)
    @options[:template_folder] || "#{File.dirname(__FILE__)}/../../templates/#{template_type}"
  end

  def ask_with_options(option, limited_to = nil)
    return @options[option] if @options[option]

    limited_to = @config[:defaults][option] if default.nil?
    ask(@config[:questions][option], limited_to: limited_to)
  end

  def ask_with_default(option, default = nil)
    return @options[option] unless @options[option].nil?

    default = @config[:defaults][option] if default.nil?
    result = ask(@questions[option])
    result != '' ? result : default
  end

  def append_or_create(file_path, file_content)
    if File.exist?(file_path)
      append_to_file file_path, file_content
    else
      create_file file_path, file_content
    end
  end
end
