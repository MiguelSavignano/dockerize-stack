require 'thor'

# Ask variables and render templates
class DockerizeStack::ThorExtend < Thor
  include Thor::Actions

  WORKDIR = ENV['DOCKERIZE_STACK_PATH'].freeze || '.'.freeze

  desc 'generate_files', ''
  def run
    raise 'implement method generate_files'
  end

  private

  def render_template(path)
    template path, "#{WORKDIR}/#{path.gsub('.erb', '')}"
  end

  def ask_with_default(question = '', default = '')
    result = ask(question)
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
