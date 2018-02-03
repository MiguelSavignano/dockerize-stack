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

end
