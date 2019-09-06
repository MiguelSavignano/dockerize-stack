module DockerizeStack
  # Ask variables and render templates
  class DockerizeRails < ThorExtend
    attr_accessor :ruby_version, :nodejs_version, :yarn_version,
      :database, :github_private, :kubernetes

    def self.source_root
      "#{File.dirname(__FILE__)}/../../templates/rails"
    end

    no_commands do
      def generate_files(path: '.')
        @workdir = path
        @nodejs_version = '10.16.3'
        @yarn_version = '1.17.3'

        @ruby_version = ask_with_default('Ruby Version (default 2.5.6):', '2.5.6')
        @database = ask('What is your Database?', limited_to: ['postgresql', 'mysql'])
        @rails_worker = ask_with_default('You need worker service (sidekiq example) (default yes):', 'yes')
        @github_private = ask_with_default('You need github token for private gems? (default no):', 'no')
        @kubernetes = ask_with_default('You want generate docker-stack for kubernetes? y/n', 'n')

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
        directory 'kubernetes', "#{WORKDIR}/kubernetes"
      end
    end
  end
end
