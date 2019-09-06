require 'thor'
# Ask variables and render templates
module DockerizeStack
  # Ask variables and render templates
  class React < ThorExtend
    attr_accessor :nodejs_version, :workdir

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
  end
end
