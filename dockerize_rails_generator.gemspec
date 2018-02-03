require File.expand_path("../lib/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'dockerize-rails-generator'
  s.version     = DockerizeRailsGenerator::VERSION
  s.executables << 'dockerize_rails_generator'
  s.date        = '2018-02-03'
  s.summary     = "DockerizeRailsGenerator"
  s.description = "Generate Dockerfile and docker-compose for your rails application"
  s.authors     = ["Miguel Savignano"]
  s.email       = 'migue.masx@gmail.com'
  s.files       = ["lib/dockerize_rails_generator.rb"]
  s.homepage    = 'https://github.com/MiguelSavignano/dockerize-rails-generator'
  s.license     = 'MIT'
end
