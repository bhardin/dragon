#!/usr/bin/env ruby
require 'rake/clean'
require 'rake/testtask'

desc "Run all of the tests"
Rake::TestTask.new do |config|
  config.libs << 'test'
  config.pattern = 'test/**/*_test*'
  config.verbose = true
  config.warning = true
end

desc 'Default: run tests'
task :default => [ :test ]
