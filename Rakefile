require 'rake'
require 'rake/rdoctask'
require 'rspec'
require 'rspec/core/rake_task'
require 'bundler'

Bundler::GemHelper.install_tasks

Rspec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
