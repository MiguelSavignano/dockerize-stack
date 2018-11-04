require 'thor'
# Ask variables and render templates
class DockerizeRails < Thor
  include Thor::Actions
  attr_accessor :ruby_version, :database, :github_private, :docker_production

  WORKDIR = ".".freeze

  def self.source_root
    File.dirname(__FILE__)
  end

  desc 'generate_files', 'generate docker files for rails application'
  def generate_files
    @ruby_version = ask_with_default('Ruby Version (default 2.5.1):', '2.5.1')
    @ruby_version = "#{@ruby_version}-slim"
    @database       = ask('What is your Database?', limited_to: ['postgresql', 'mysql'])
    @github_private = ask_with_default('You need github token for private gems? (default no):', 'no')
    @docker_production = ask_with_default("You want generate docker-stack for production?", 'no')

    render_templates
    render_production_templates if @docker_production == ''
  end

  no_commands do
    def render_templates
      template 'templates/docker/development/Dockerfile.erb', "#{WORKDIR}/docker/development/Dockerfile"
      template 'templates/docker/development/entrypoint.sh.erb', "#{WORKDIR}/docker/development/entrypoint.sh"
      template 'templates/docker-compose.yml.erb', "#{WORKDIR}/docker-compose.yml"
      template 'templates/config/database-docker.yml.erb', "#{WORKDIR}/config/database-docker.yml"
      template 'templates/dockerignore.erb', "#{WORKDIR}/.dockerignore"
      puts 'Update your database.yml based in database-docker.yml'
    end

    def render_production_templates
      directory 'templates/docker/production', "#{WORKDIR}/docker/production"
      directory 'templates/docker/kubernetes', "#{WORKDIR}/docker/kubernetes"

      template 'templates/docker/Dockerfile.erb', "#{WORKDIR}/docker/production/rails/Dockerfile"
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
