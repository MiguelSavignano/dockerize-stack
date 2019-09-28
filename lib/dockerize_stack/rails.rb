module DockerizeStack
  # Ask variables and render templates
  class Rails < Thor
    include Thor::Actions
    include ThorActionsExtend

    attr_accessor :ruby_version, :javascrit_package_manager, :nodejs_version,
                  :yarn_version, :database, :github_private, :kubernetes, :output_folder

    def self.source_root
      "#{File.dirname(__FILE__)}/../../templates/rails"
    end

    no_commands do
      def fetch_template_variables
        @output_folder             = @options[:output_folder]
        @nodejs_version            = @options[:nodejs_version]
        @yarn_version              = @options[:yarn_version]

        @ruby_version              = ask_with_default(:ruby_version, '2.5.6')
        @javascrit_package_manager = ask_with_options(:javascrit_package_manager, %w[asset_pipeline yarn npm])
        @database                  = ask_with_options(:database, %w[postgresql mysql])
        @rails_worker              = ask_with_default(:rails_worker, 'y')
        @github_private            = ask_with_default(:github_private, 'n')
        @kubernetes                = ask_with_default(:kubernetes, 'n')
      end

      def generate_files(options)
        @options = options
        @questions = STRINGS[:rails][:questions]
        fetch_template_variables
        render_templates
        render_kubernetes_templates unless ['n', 'no', ''].include?(@kubernetes)
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
