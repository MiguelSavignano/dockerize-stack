require 'thor'
require_relative './dockerize_stack//thor_extend.rb'
require_relative './dockerize_stack/dockerize_react.rb'
require_relative './dockerize_stack/dockerize_rails.rb'

module DockerizeStack
  class Command < DockerizeStack::ThorExtend
    include Thor::Actions

    option :path
    desc 'rails', 'generate docker files for rails application'
    def rails
      DockerizeStack::DockerizeRails.new.generate_files(path: options[:path])
    end

    option :path
    desc 'react', 'generate docker files for create react app'
    def react
      DockerizeStack::DockerizeReact.new.generate_files(path: options[:path])
    end
  end
end
