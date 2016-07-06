require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  puts 'Cannot require "rubocop/rake_task".'
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = 'features --format pretty'
  end
rescue LoadError
  puts 'Cannot require "rubocop/rake_task".'
end

begin
  require 'yard'
  require 'yard/rake/yardoc_task'
  YARD::Rake::YardocTask.new
rescue LoadError
  puts 'Cannot require "yard/rake/yardoc_task".'
end

Bundler::GemHelper.install_tasks

# TODO: https://github.com/bbatsov/rubocop/issues/3267
#task default: %i(spec features rubocop yard build)
task default: %i(spec features yard build)
