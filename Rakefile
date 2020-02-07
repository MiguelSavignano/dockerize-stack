# frozen_string_literal: true

task default: %w[test]

task :test do
  system 'rspec'
end

task :release do
  system 'gem build *.gemspec'
  system 'gem push *.gem'
end
