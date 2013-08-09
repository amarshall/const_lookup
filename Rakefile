require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.ruby_opts = '-w' unless ENV['TRAVIS']
end

task :default => :spec
