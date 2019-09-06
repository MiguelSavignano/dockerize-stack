require_relative '../lib/dockerize_stack'
require 'pry'

describe 'DockerizeStack::Rails' do
  it '#initialize' do
    generator = DockerizeStack::Rails.new
    expect(generator).to be_a(DockerizeStack::Rails)
  end

  it '#render_templates' do
    generator = DockerizeStack::Rails.new
    generator.workdir = './examples/rails'
    generator.ruby_version = '2.5.6'
    generator.database = 'postgresql'
    generator.github_private = 'no'
    generator.kubernetes = 'y'

    generator.render_templates
    generator.render_kubernetes_templates
  end

  # Test build docker image
  # docker build -t dockerize-stak-rails-example -f docker/development/Dockerfile examples/rails
end

describe 'DockerizeReact' do
  it '#initialize' do
    generator = DockerizeStack::React.new
    expect(generator).to be_a(DockerizeStack::React)
  end

  it '#render_templates' do
    generator = DockerizeStack::React.new
    generator.workdir = './examples/react-create-app'

    generator.nodejs_version = '10'
    generator.render_templates
  end
end
