require 'thor'

class DockerizeRails < Thor
  include Thor::Actions
  attr_accessor :ruby_version, :database

  def self.source_root
    File.dirname(__FILE__)
  end

  desc 'generate_files', 'generate docker files for rails application'
  def generate_files
    @ruby_version = ask("Ruby Version (default 2.4.3):")
    @ruby_version = "2.4.3" if @ruby_version == ""
    @database     = ask("What is your Database?", limited_to: ["mysql", "postgresql"])

    template "templates/Dockerfile.erb", "docker/development/Dockerfile"
    template "templates/entrypoint.sh", "docker/development/entrypoint.sh"
    template "templates/docker-compose.yml.erb", "docker-compose.yml"
    template "templates/database-docker.yml.erb", "config/database-docker.yml"
    template "templates/dockerignore", ".dockerignore"
    append_to_file '.gitignore', "
volumes"
    puts "Update your database.yml based in database-docker.yml"
  end

end
