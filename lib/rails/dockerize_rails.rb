require 'thor'
# Ask variables and render templates
class DockerizeRails < Thor
  include Thor::Actions
  attr_accessor :ruby_version, :database, :id_rsa

  WORKDIR = "./examples/rails".freeze

  def self.source_root
    File.dirname(__FILE__)
  end

  desc 'generate_files', 'generate docker files for rails application'
  def generate_files
    ruby_version = ask('Ruby Version (default 2.5.1):')
    ruby_version = '2.5.1-slim' if ruby_version == ''
    database     = ask('What is your Database?', limited_to: ['postgresql', 'mysql'])
    id_rsa       = ask('Would you need your id_rsa file to connect with GitHub? Type yes or no (default no):')
    id_rsa       = 'no' if id_rsa == ''
    render_templates(ruby_version: ruby_version, database: database, id_rsa: id_rsa)
    render_production_templates(ruby_version: ruby_version, database: database, id_rsa: id_rsa)

    puts 'Update your database.yml based in database-docker.yml'
  end

  no_commands do
    def render_templates(ruby_version: '2.5.1-slim', database: 'postgresql', id_rsa: 'no')
      @ruby_version = ruby_version
      @database     = database
      @id_rsa       = id_rsa

      template 'templates/docker/development/Dockerfile.erb', "#{WORKDIR}/docker/development/Dockerfile"
      template 'templates/docker/development/entrypoint.sh.erb', "#{WORKDIR}/docker/development/entrypoint.sh"
      template 'templates/docker-compose.yml.erb', "#{WORKDIR}/docker-compose.yml"
      template 'templates/config/database-docker.yml.erb', "#{WORKDIR}/config/database-docker.yml"
      template 'templates/dockerignore.erb', "#{WORKDIR}/.dockerignore"

      append_to_file "#{WORKDIR}/.gitignore", '
volumes'
      if @id_rsa == 'yes'
        template 'templates/id_rsa.sample', "#{WORKDIR}/id_rsa.sample"
        append_to_file "#{WORKDIR}/.gitignore", '
id_rsa'
        append_to_file "#{WORKDIR}/.gitignore", '
id_rsa.sample'
      end
      puts 'Update your database.yml based in database-docker.yml'
    end

    def render_production_templates(ruby_version: '2.5.1-slim', database: 'postgresql', id_rsa: 'no')
      @ruby_version = ruby_version
      @database     = database
      @id_rsa       = id_rsa

      directory 'templates/docker/production', "#{WORKDIR}/docker/production"
      directory 'templates/docker/kubernetes', "#{WORKDIR}/docker/kubernetes"

      template 'templates/docker/Dockerfile.production.erb', "#{WORKDIR}/docker/production/rails/Dockerfile"
    end
  end
end
