require 'thor'
require_relative './thor_extend.rb'
require_relative './dockerize_stack/react.rb'
require_relative './dockerize_stack/rails.rb'

module DockerizeStack
  class Command < Thor
    include Thor::Actions
    include ThorActionsExtend

    option :template_folder,
           aliases: 't',
           desc: 'Template folder path'
    option :output_folder,
           default: '.',
           aliases: 'o',
           desc: 'Output folder'
    option :ruby_version,
           banner: [],
           desc: 'Ruby version'
    option :javascrit_package_manager,
           banner: 'npm',
           enum: []
    option :nodejs_version,
           banner: [],
           desc: 'Nodejs version'
    option :yarn_version,
           banner: [],
           desc: 'Yarn version'
    option :database,
           banner: 'postgresql',
           enum: [],
           desc: 'Database type'
    option :rails_worker,
           type: :boolean,
           banner: [],
           desc: 'Rails sidekiq examples in docker-compose.yml'
    option :github_private,
           type: :boolean,
           banner: [],
           desc: 'Set GITHUB_USERNAME and GITHUB_TOKEN in dockerfile bundle config'
    option :kubernetes,
           type: :boolean,
           banner: [],
           desc: 'Basic examples for kubernetes config (minikube)'

    desc 'rails', 'generate docker files for rails application'
    def rails
       run(options, :rails)
       render_template 'Dockerfile.erb'
       render_template 'dockerignore.erb', '.dockerignore'
       directory 'nginx', "#{@output_folder}/nginx"
       render_template 'Dockerfile.erb'
       render_template 'entrypoint.sh.erb'
       render_template 'docker-compose.yml.erb'
       render_template 'config/database-docker.yml.erb'
       render_template 'dockerignore.erb', '.dockerignore'

       if @kubernetes
         directory 'kubernetes', "#{@output_folder}/kubernetes"
       end
       puts 'Update your database.yml based in database-docker.yml'
    end

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'
    option :nodejs_version, banner: '10.16.3', dec: 'Nodejs version'

    desc 'react', 'generate docker files for create react app'
    def react
      run(options, :react)
      render_template 'Dockerfile.erb'
      render_template 'dockerignore.erb', '.dockerignore'
      directory 'nginx', "#{@output_folder}/nginx"
    end
  end
end
