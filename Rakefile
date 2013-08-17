require 'rake/testtask'

task :default => [:'']

desc "Run all tests"
task :'' do
  Rake::TestTask.new("alltests") do |t|
    t.test_files = Dir.glob(File.join("test", "**", "*_test.rb"))
  end
  task("alltests").execute
end

namespace :db do
  require 'sinatra'
  require 'dm-core'
  require 'dm-types'
  require 'dm-validations'
  require 'dm-migrations'

  require_relative './app'

  desc "Upgrade database schema"
  task :upgrade do
    DataMapper.auto_upgrade!
  end
end
