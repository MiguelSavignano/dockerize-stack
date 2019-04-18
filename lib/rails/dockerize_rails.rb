require 'thor'
# Ask variables and render templates
class DockerizeRails < Thor
  include Thor::Actions
  attr_accessor :ruby_version, :database, :github_private, :docker_production

  WORKDIR = ".".freeze

  def self.source_root
    "#{File.dirname(__FILE__)}/../../templates"
  end

  desc 'generate_files', 'generate docker files for rails application'
  def generate_files
    @ruby_version = ask_with_default('Ruby Version (default 2.5.1):', '2.5.1')
    @database       = ask('What is your Database?', limited_to: ['postgresql', 'mysql'])
    @github_private = ask_with_default('You need github token for private gems? (default no):', 'no')
    @docker_production = ask_with_default("You want generate docker-stack for production? y/n", 'n')

    render_templates
    render_production_templates if @docker_production != 'n' || @docker_production != 'no'
  end

  no_commands do
    def render_templates
      template 'rails/docker/development/Dockerfile.erb', "#{WORKDIR}/docker/development/Dockerfile"
      template 'rails/docker/development/entrypoint.sh.erb', "#{WORKDIR}/docker/development/entrypoint.sh"
      template 'rails/docker-compose.yml.erb', "#{WORKDIR}/docker-compose.yml"
      template 'rails/config/database-docker.yml.erb', "#{WORKDIR}/config/database-docker.yml"
      template 'rails/dockerignore.erb', "#{WORKDIR}/.dockerignore"
      puts 'Update your database.yml based in database-docker.yml'
    end

    def render_production_templates
      directory 'rails/docker/production', "#{WORKDIR}/docker/production"
      directory 'rails/docker/kubernetes', "#{WORKDIR}/docker/kubernetes"

      template 'rails/docker/production/rails/Dockerfile.erb', "#{WORKDIR}/docker/production/rails/Dockerfile"
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
