require 'thor'
require_relative './thor_extend.rb'
require_relative './dockerize_stack/react.rb'
require_relative './dockerize_stack/rails.rb'

module DockerizeStack
  class Command < Thor
    include Thor::Actions

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'
    option :ruby_version, banner: '2.5.6', desc: 'Ruby version'
    option :javascrit_package_manager, banner: 'npm', enum: %w[asset_pipeline yarn npm]
    option :nodejs_version, banner: '2.5.6', desc: 'Nodejs version'
    option :yarn_version, banner: '2.5.6', desc: 'Yarn version'
    option :database, banner: 'postgresql', enum: %w[postgresql mysql], desc: 'Database type'
    option :rails_worker, type: :boolean, desc: 'Rails sidekiq examples in docker-compose.yml'
    option :github_private, type: :boolean, desc: 'Set GITHUB_USERNAME and GITHUB_TOKEN in dockerfile bundle config'
    option :kubernetes, type: :boolean, desc: 'Basic examples for kubernetes config (minikube)'

    desc 'rails', 'generate docker files for rails application'
    def rails
      DockerizeStack::Rails.new.run(options)
    end

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'
    option :nodejs_version, banner: '10.16.3', dec: 'Nodejs version'

    desc 'react', 'generate docker files for create react app'
    def react
      DockerizeStack::React.new.run(options)
    end
  end
end
