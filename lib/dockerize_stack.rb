require 'thor'
require 'rails/dockerize_rails'
require 'react/dockerize_react'

module DockerizeStack
  class Command < Thor
    include Thor::Actions

    desc 'rails', 'generate docker files for rails application'
    def rails
      DockerizeRails.new.generate_files
    end

    desc 'react', 'generate docker files for create react app'
    def react
      DockerizeReact.new.generate_files
    end
  end
end
