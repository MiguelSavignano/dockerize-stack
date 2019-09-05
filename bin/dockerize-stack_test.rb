require 'dockerize_stack'

DockerizeRails::WORKDIR = './examples/rails'
DockerizeStack::Command.start

# ruby bin/dockerize-stack_test.rb rails
