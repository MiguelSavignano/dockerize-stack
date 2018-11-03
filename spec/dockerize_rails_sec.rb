require 'rails/dockerize_rails'
require 'pry'

describe "DockerizeRails" do

  it "#initialize" do
    generator = DockerizeRails.new
    expect(generator).to be_a(DockerizeRails)
  end

  # it "#generate_files" do
  #   generator = DockerizeRails.new
  #   generator.generate_files
  # end

  it "#render_templates" do
    generator = DockerizeRails.new
    generator.ruby_version = '2.5.1-slim'
    generator.database = 'postgresql'
    generator.github_private = 'yes'

    generator.render_templates
  end

  # it "#render_production_templates" do
  #   generator = DockerizeRails.new
  #   generator.render_production_templates
  # end

end
