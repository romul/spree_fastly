require 'bundler'
require 'yaml'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'spree/testing_support/extension_rake'

RSpec::Core::RakeTask.new

task :default do
  if Dir["spec/dummy"].empty?
    Rake::Task[:test_app].invoke
    Dir.chdir("../../")
  end
  Rake::Task[:spec].invoke
end

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'spree_fastly'
  Rake::Task['extension:test_app'].invoke
  Rake::Task['dummy_fastly_config'].invoke
end

desc 'Creates a dummy Fastly config'
task :dummy_fastly_config do
  dummy_config = <<-eos
FastlyRails.configure do |c|
  c.api_key = 'dummy-api-key'
  c.user = 'dummy-user'
  c.password = 'dummy-password'
  c.max_age = 86400 # time in seconds, optional, defaults to 2592000
  c.service_id = 'dummy-service-id'
end
  eos

  File.open('spec/dummy/config/initializers/fasty.rb', 'w') { |file| file.write dummy_config }
end
