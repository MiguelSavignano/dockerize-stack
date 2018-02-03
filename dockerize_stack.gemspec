lib = File.expand_path('../lib', __FILE__)
require File.expand_path("../lib/version", __FILE__)
Gem::Specification.new do |s|
  s.name        = 'dockerize-stack'
  s.version     = DockerizeStack::VERSION
  s.executables << 'dockerize_stack'
  s.date        = '2018-02-03'
  s.summary     = "DockerizeStack"
  s.description = "Generate Dockerfile and docker-compose for your application"
  s.authors     = ["Miguel Savignano"]
  s.email       = 'migue.masx@gmail.com'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md) + ["lib/rails/templates/Dockerfile.erb"]
  s.homepage    = 'https://github.com/MiguelSavignano/dockerize-rails-generator'
  s.license     = 'MIT'
  s.require_paths = ['lib']
  s.add_runtime_dependency 'thor', '~> 0'
end
