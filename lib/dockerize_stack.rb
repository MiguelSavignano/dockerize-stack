# frozen_string_literal: true

require 'thor'
require_relative './thor_extend.rb'

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

    CONFIG[:rails][:questions].each do |question|
      option question[:option],
             desc: question[:title]
    end

    desc 'rails', 'generate docker files for rails application'
    def rails
      run(options, :rails)

      Dir.glob("./templates/rails/**/*").select{|x| !File.directory?(x) }.each do |file_path|
        file_name = file_path.gsub("/templates/rails", "")
        render_template file_name
      end

      # Dir.glob("./templates/rails/**/*")
      # render_template 'Dockerfile.erb'
      # render_template 'dockerignore.erb', '.dockerignore'
      # directory 'nginx', "#{@output_folder}/nginx"
      # render_template 'Dockerfile.erb'
      # render_template 'entrypoint.sh.erb'
      # render_template 'docker-compose.yml.erb'
      # render_template 'config/database-docker.yml.erb'
      # render_template 'dockerignore.erb', '.dockerignore'

      directory 'kubernetes', "#{@output_folder}/kubernetes" if @kubernetes
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
