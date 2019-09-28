require 'yaml'
require 'json'

module ThorActionsExtend
  include Thor::Actions

  STRINGS = JSON.parse(
      JSON.dump(YAML.load_file("#{File.dirname(__FILE__)}/strings.yml")),
      symbolize_names: true
    )

  def render_template(path)
    template path, "#{@output_folder}/#{path.gsub('.erb', '')}"
  end


  private
  def render_template(path)
    template path, "#{@output_folder}/#{path.gsub('.erb', '')}"
  end

  def ask_with_options(option, limited_to)
    return @options[option] if @options[option]

    ask(@questions[option], limited_to: limited_to)
  end

  def ask_with_default(option, default = '')
    return @options[option] unless @options[option].nil?

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
