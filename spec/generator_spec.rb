require 'dockerize_rails_generator'
require 'pry'

describe "Generator" do

  it "#initialize" do
    generator = Generator.new
    expect(generator).to be_a(Generator)
  end

  # it "#generate_files" do
  #   generator = Generator.new
  #   generator.generate_files
  # end

end
