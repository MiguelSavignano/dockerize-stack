require 'rails/dockerize_rails'
require 'react/dockerize_react'
require 'pry'

describe "DockerizeRails" do

  it "#initialize" do
    generator = DockerizeRails.new
    expect(generator).to be_a(DockerizeRails)
  end

  it "#render_templates" do
    DockerizeRails::WORKDIR = "./examples/rails"
    generator = DockerizeRails.new
    generator.ruby_version = '2.5.1-slim'
    generator.database = 'postgresql'
    generator.github_private = 'no'
    generator.docker_production = 'yes'

    generator.render_templates
    generator.render_production_templates
  end

  # Test build docker image
  # docker build -t dockerize-stak-rails-example -f docker/development/Dockerfile examples/rails
end

describe "DockerizeReact" do
    it "#initialize" do
    generator = DockerizeReact.new
    expect(generator).to be_a(DockerizeReact)
  end

  it "#render_templates" do
    DockerizeReact::WORKDIR = "./examples/react-create-app"
    generator = DockerizeReact.new
    generator.nodejs_version = '10'
    generator.render_templates
  end
end
