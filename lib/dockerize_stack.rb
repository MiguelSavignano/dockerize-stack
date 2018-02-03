require 'thor'
require 'rails/dockerize_rails'

module DockerizeStack
  class Command < Thor
    include Thor::Actions

    desc 'rails', 'generate docker files for rails application'
    def rails
      DockerizeRails.new.generate_files
    end
  end
end
