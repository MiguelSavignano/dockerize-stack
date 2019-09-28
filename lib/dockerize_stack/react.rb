require 'thor'
# Ask variables and render templates
module DockerizeStack
  # Ask variables and render templates
  class React < Thor
    include Thor::Actions
    include ThorActionsExtend

    attr_accessor :nodejs_version, :output_folder

    no_commands do
      def template_type
        :react
      end

      def fetch_template_variables
        @output_folder = @options[:output_folder]
        @nodejs_version = ask_with_default(:nodejs_version)
      end

      def render_templates
        render_template 'Dockerfile.erb'
        render_template '.dockerignore.erb'

        directory 'nginx', "#{@output_folder}/nginx"
      end
    end
  end
end
