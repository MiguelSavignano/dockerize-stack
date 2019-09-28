require_relative '../lib/dockerize_stack'
require 'pry'

describe 'DockerizeStack::Rails' do
  it '#initialize' do
    generator = DockerizeStack::Rails.new
    expect(generator).to be_a(DockerizeStack::Rails)
  end

  it '#render_templates' do
    generator = DockerizeStack::Rails.new
    options = {
      output_folder: './examples/rails',
      ruby_version:  '2.5.6',
      nodejs_version:  '10.16.3',
      yarn_version:  '1.17.3',
      javascrit_package_manager: 'npm',
      database:  'postgresql',
      rails_worker: false,
      github_private:  false,
      kubernetes: false
    }

    generator.run(options)
  end

  # Test build docker image
  # docker build -t dockerize-stak-rails-example -f docker/development/Dockerfile examples/rails
end

describe 'DockerizeStack::React' do
  it '#initialize' do
    generator = DockerizeStack::React.new
    expect(generator).to be_a(DockerizeStack::React)
  end

  it '#render_templates' do
    generator = DockerizeStack::React.new

    options = {
      output_folder: './examples/react-create-app',
      nodejs_version:  '10.16.3'
    }

    generator.generate_files(options)
  end
end
