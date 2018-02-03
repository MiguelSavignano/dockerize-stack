require 'thor'

class Generator < Thor
  include Thor::Actions
  attr_accessor :mainteiner, :ruby_version, :database

  def self.source_root
    File.expand_path('../templates', __FILE__)
  end

  def set_variables
    @mainteiner   = ask("Mainteiner email:")
    @mainteiner   = "example@mail.com" if @mainteiner == ""
    @ruby_version = ask("Ruby Version (default 2.4.3):")
    @ruby_version = "2.4.3" if @ruby_version == ""
    @database     = ask("What is your Database?", limited_to: ["mysql", "postgresql"])
  end

  def generate_files
    set_variables

    template "Dockerfile.erb", "docker/development/Dockerfile"
    template "entrypoint.sh", "docker/development/entrypoint.sh"
    template "docker-compose.yml.erb", "docker-compose.yml"
    template "database_docker.yml.erb", "config/database_docker.yml"
    template ".dockerignore", ".dockerignore"
    append_to_file '.gitignore', "
volumes"
  end

end
