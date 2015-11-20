require 'rails'
require 'pg_comment/version'
require 'active_support/all'

# In any PostgreSQL database where the Rails app is not the only consumer, it
# is very helpful to have comments on the various elements of the schema.
# PgComment extends the migrations DSL with methods to set and remove comments
# on columns, tables and indexes. It also dumps those comments into your
# schema.rb.
module PgComment

  module ConnectionAdapters # :nodoc:
  end

  module Migration # :nodoc:
  end
end

if defined?(Rails)
  require 'pg_comment/schema_dumper'
  require 'pg_comment/migration/command_recorder'
  require 'pg_comment/connection_adapters/abstract/schema_definitions'
  require 'pg_comment/connection_adapters/abstract/schema_statements'
  require 'pg_comment/connection_adapters/postgresql_adapter'

  require 'pg_comment/engine'
end
