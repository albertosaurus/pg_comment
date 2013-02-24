#require 'rubygems'
gem 'test-unit'

if require 'simplecov'
  SimpleCov.start do
    add_filter 'test/'
  end
end

require 'test/unit'
require 'active_record'


require 'pg_comment/connection_adapters/postgresql_adapter'
require 'fake_connection'
require 'pg_comment/schema_dumper'