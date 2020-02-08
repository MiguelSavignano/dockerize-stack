# frozen_string_literal: true

require_relative '../lib/dockerize_stack'
require 'pry'

describe 'DockerizeStack::Rails' do
  it '#rails' do
    generator = DockerizeStack::Command.new
    generator.options = {
      'output_folder' => './examples/rails',
      'ruby_version' => '2.5.6',
      'nodejs_version' => '10.16.3',
      'yarn_version' => '1.17.3',
      'javascrit_package_manager' => 'npm',
      'database' => 'postgresql',
      'rails_worker' => false,
      'github_private' => false,
      'kubernetes' => false
    }

    generator.rails
    # Test build docker image
    # docker build -t dockerize-stak-rails-example -f Dockerfile examples/rails
  end

  it '#react' do
    generator = DockerizeStack::Command.new
    generator.options = {
      "output_folder" => './examples/react-create-app',
      "nodejs_version" => '10.16.3'
    }

    generator.react
  end
end
