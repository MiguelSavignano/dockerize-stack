require 'thor'
require_relative './thor_extend.rb'
require_relative './dockerize_stack/react.rb'
require_relative './dockerize_stack/rails.rb'

module DockerizeStack
  class Command < Thor
    include Thor::Actions

    option :output_folder, default: '.'
    option :ruby_version
    option :nodejs_version, default: '10.16.3'
    option :yarn_version
    option :javascrit_package_manager, enum: %w[asset_pipeline yarn npm]
    option :database, enum: %w[postgresql mysql]
    option :rails_worker, type: :boolean
    option :github_private, type: :boolean
    option :kubernetes, type: :boolean

    desc 'rails', 'generate docker files for rails application'
    def rails
      DockerizeStack::Rails.new.generate_files(options)
    end

    option :path
    desc 'react', 'generate docker files for create react app'
    def react
      DockerizeStack::React.new.generate_files(path: options[:path])
    end
  end
end
