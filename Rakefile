#!/usr/bin/env rake
require "bundler/gem_tasks"
require "yard"
require "rake/clean"
require "rake/testtask"
require "pry"

begin
  Bundler.setup :default, :development
  Bundler::GemHelper.install_tasks
rescue Bundler::BundlerError => error
  $stderr.puts error.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit error.status_code
end

Rake.application.options.suppress_backtrace_pattern = /#{ENV["HOME"]}/
desc "Run all of the tests"
Rake::TestTask.new(:test) do |config|
  config.libs << "test"
  config.pattern = "test/**/*_test.rb"
  config.verbose = false
end

desc "Generate all of the docs"
YARD::Rake::YardocTask.new do |config|
  config.files = Dir["lib/**/*.rb"]
end
desc "Default: run tests and generate docs"
task :default => [ :test, :yard ]
