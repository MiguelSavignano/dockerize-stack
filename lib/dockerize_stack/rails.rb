module DockerizeStack
  # Ask variables and render templates
  class Rails < Thor
    include Thor::Actions
    include ThorActionsExtend

    attr_accessor :ruby_version, :javascrit_package_manager, :nodejs_version,
                  :yarn_version, :database, :github_private, :kubernetes, :output_folder

    no_commands do
      def template_type
        :rails
      end

      def run(options)
        super(options)
        render_kubernetes_templates unless ['n', 'no', '', false].include?(@kubernetes)
      end

      def fetch_template_variables
        @output_folder             = @options[:output_folder]
        @nodejs_version            = @options[:nodejs_version]
        @yarn_version              = @options[:yarn_version]

        @ruby_version              = ask_with_default(:ruby_version)
        @javascrit_package_manager = ask_with_options(:javascrit_package_manager)
        @database                  = ask_with_options(:database)
        @rails_worker              = ask_with_default_boolean(:rails_worker)
        @github_private            = ask_with_default_boolean(:github_private)
        @kubernetes                = ask_with_default_boolean(:kubernetes)
      end

      def render_templates
        render_template 'Dockerfile.erb'
        render_template 'entrypoint.sh.erb'
        render_template 'docker-compose.yml.erb'
        render_template 'config/database-docker.yml.erb'
        render_template '.dockerignore.erb'

        puts 'Update your database.yml based in database-docker.yml'
      end

      def render_kubernetes_templates
        directory 'kubernetes', "#{@output_folder}/kubernetes"
      end
    end
  end
end
