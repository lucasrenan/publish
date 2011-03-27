#generates coverage report
begin
  require 'simplecov'
  SimpleCov.start('rails') do
    add_filter '/vendor/'
  end
rescue
end

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Run any available migration
#ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load factories
Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each { |f| require f }


class ActiveSupport::TestCase
  teardown do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end

class ActionController::TestCase
  teardown do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end