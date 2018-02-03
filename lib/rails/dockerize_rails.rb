require 'thor'

class DockerizeRails < Thor
  include Thor::Actions
  attr_accessor :ruby_version, :database

  def self.source_root
    File.dirname(__FILE__)
  end

  def set_variables
    @ruby_version = ask("Ruby Version (default 2.4.3):")
    @ruby_version = "2.4.3" if @ruby_version == ""
    @database     = ask("What is your Database?", limited_to: ["mysql", "postgresql"])
  end

  def generate_files
    set_variables

    template "templates/Dockerfile.erb", "docker/development/Dockerfile"
    template "templates/entrypoint.sh", "docker/development/entrypoint.sh"
    template "templates/docker-compose.yml.erb", "docker-compose.yml"
    template "templates/database_docker.yml.erb", "config/database_docker.yml"
    template "templates/dockerignore", ".dockerignore"
    append_to_file '.gitignore', "
volumes"
  end

end
