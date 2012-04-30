require "bundler/gem_tasks"
require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
