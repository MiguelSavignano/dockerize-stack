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
    @id_rsa       = ask("Would you need your id_rsa file?", limited_to: ["yes", "no"])

    template "templates/Dockerfile.erb", "docker/development/Dockerfile"
    template "templates/entrypoint.sh.erb", "docker/development/entrypoint.sh"
    template "templates/docker-compose.yml.erb", "docker-compose.yml"
    template "templates/database-docker.yml.erb", "config/database-docker.yml"
    template "templates/dockerignore.erb", ".dockerignore"

    append_to_file '.gitignore', "volumes"
    if @id_rsa == 'yes'
      template "templates/id_rsa.sample", "id_rsa.sample"      
      append_to_file '.gitignore', "id_rsa"
      append_to_file '.gitignore', "id_rsa.sample"
    end
    
    puts "Update your database.yml based in database-docker.yml"
  end

end
