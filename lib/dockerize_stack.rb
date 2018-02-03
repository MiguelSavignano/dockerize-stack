require 'thor'
require 'rails/dockerize_rails'

module DockerizeStack
  def self.rails
    puts "Hi"
    DockerizeRails.new.generate_files
  end
end
