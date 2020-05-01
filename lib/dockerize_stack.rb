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
      all_file_paths(:rails).each do |file_path|
        if file_path =~ %r{./templates/rails/kubernetes} && !@kubernetes
          return false
        end

        file_name = file_path.gsub('/templates/rails', '')
        template file_name, "#{@output_folder}/#{file_name.gsub('.erb', '')}"
      end
      render_template! '.dockerignore.erb'

      puts 'Update your database.yml based in database-docker.yml'
    end

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'
    option :nodejs_version, banner: '10.16.3', dec: 'Nodejs version'

    desc 'react', 'generate docker files for create react app'
    def react
      run(options, :react)
      all_file_paths(:react).each do |file_path|
        file_name = file_path.gsub('/templates/react', '')
        template file_name, "#{@output_folder}/#{file_name.gsub('.erb', '')}"
      end
      render_template! '.dockerignore.erb'
    end

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'

    CONFIG[:gatsby][:questions].each do |question|
      option question[:option], desc: question[:title]
    end

    desc 'gatsby', 'generate docker files for gatsby app'
    def gatsby
      @type = :gatsby
      run(options, @type)
      all_file_paths(@type).each do |file_path|
        file_name = file_path.gsub("/templates/#{@type}", '')
        template file_name, "#{@output_folder}/#{file_name.gsub('.erb', '')}"
      end
      render_template! '.dockerignore.erb'
    end
  end
end
