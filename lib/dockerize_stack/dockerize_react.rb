require 'thor'
# Ask variables and render templates
module DockerizeStack
  # Ask variables and render templates
  class DockerizeReact < ThorExtend
    attr_accessor :nodejs_version

    def self.source_root
      "#{File.dirname(__FILE__)}/../../templates/react"
    end

    no_commands do
      def generate_files(path: '.')
        @workdir = path
        @nodejs_version = ask_with_default('Nodejs Version (default 10):', '10')

        render_templates
      end

      def render_templates
        render_template 'Dockerfile.erb'
        render_template '.dockerignore.erb'

        directory 'nginx', "#{@workdir}/nginx"
      end
    end

    private

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
end
