ENV['RAILS_ENV'] = 'test'

unless ENV['TRAVIS']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec/'
  end
end

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
end
