# frozen_string_literal: true

require 'thor'
require_relative './thor_extend.rb'

module DockerizeStack
  class Command < Thor
    include Thor::Actions
    include ThorActionsExtend

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'

    CONFIG[:rails][:questions].each do |question|
      option question[:option],
             desc: question[:title]
    end

    desc 'rails', 'generate docker files for rails application'
    def rails
      run(options, :rails)
      all_file_paths.each do |file_name|
        if file_name =~ %r{kubernetes/} && !@kubernetes
          return false
        end
        template file_name, "#{@output_folder}/#{file_name.gsub('.erb', '')}"
      end

      puts 'Update your database.yml based in database-docker.yml'
    end

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'
    CONFIG[:react][:questions].each do |question|
      option question[:option], desc: question[:title]
    end

    desc 'react', 'generate docker files for create react app'
    def react
      run(options, :react)
      render_all
    end

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'

    CONFIG[:gatsby][:questions].each do |question|
      option question[:option], desc: question[:title]
    end

    desc 'gatsby', 'generate docker files for gatsby app'
    def gatsby
      run(options, :gatsby)
      render_all
    end

    option :template_folder, aliases: 't', desc: 'Template folder path'
    option :output_folder, default: '.', aliases: 'o', desc: 'Output folder'

    CONFIG[:strapi][:questions].each do |question|
      option question[:option], desc: question[:title]
    end

    desc 'strapi', 'generate docker files for strapi app'
    def strapi
      run(options, :strapi)
      render_all
    end
  end
end
