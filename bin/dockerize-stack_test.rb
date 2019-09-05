require 'dockerize_stack'
require_relative '../lib/rails/dockerize_rails'

DockerizeRails::WORKDIR = "./examples/rails"
DockerizeStack::Command.start

# ruby bin/dockerize-stack_test.rb rails
