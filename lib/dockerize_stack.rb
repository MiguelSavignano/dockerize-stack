require 'thor'
require 'rails/dockerize_rails'

module DockerizeStack
  def self.rails
    DockerizeRails.new.generate_files
  end
end
