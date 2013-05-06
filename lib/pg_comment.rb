require 'pg_comment/version'
require 'active_support/all'

# In any PostgreSQL database where the Rails app is not the only consumer, it
# is very helpful to have comments on the various elements of the schema.
# PgComment extends the migrations DSL with methods to set and remove comments
# on columns, tables and indexes. It also dumps those comments into your
# schema.rb.
module PgComment
  extend ActiveSupport::Autoload
  autoload :Adapter
  autoload :SchemaDumper

  module ConnectionAdapters # :nodoc:
    extend ActiveSupport::Autoload

    autoload_under 'abstract' do
      autoload :SchemaDefinitions
      autoload :SchemaStatements
    end
  end

  module Migration # :nodoc:
    autoload :CommandRecorder, 'pg_comment/migration/command_recorder'
  end
end

require 'pg_comment/engine' if defined?(Rails)