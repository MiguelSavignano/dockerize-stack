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
        render_kubernetes_templates if @kubernetes
      end

      def render_templates
        render_template 'Dockerfile.erb'
        render_template 'entrypoint.sh.erb'
        render_template 'docker-compose.yml.erb'
        render_template 'config/database-docker.yml.erb'
        render_template 'dockerignore.erb', '.dockerignore'

        puts 'Update your database.yml based in database-docker.yml'
      end

      def render_kubernetes_templates
        directory 'kubernetes', "#{@output_folder}/kubernetes"
      end
    end
  end
end
