require 'dockerize_rails_generator/generator'

module DockerizeRailsGenerator
  def self.run
    Generator.new.generate_files
  end
end