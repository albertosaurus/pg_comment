module PgComment

  # PgComment engine.  See docs on Rails engines.
  class Engine < Rails::Engine
    initializer 'pg_comment.load_adapter' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::ConnectionAdapters.module_eval do
          include PgComment::ConnectionAdapters::SchemaStatements
          include PgComment::ConnectionAdapters::SchemaDefinitions
        end

        ActiveRecord::SchemaDumper.class_eval do
          include PgComment::SchemaDumper
        end

        if defined?(ActiveRecord::Migration::CommandRecorder)
          ActiveRecord::Migration::CommandRecorder.class_eval do
            include PgComment::Migration::CommandRecorder
          end
        end

        conf_name = ActiveRecord::Base.connection_pool.spec.config[:adapter]
        if conf_name == 'postgresql' || conf_name == "postgis"
          ["PostGISAdapter::MainAdapter", "PostgreSQLAdapter", "JdbcAdapter"].each do |adapter|
            begin
              ::ActiveRecord::ConnectionAdapters.const_get(adapter).class_eval do
                include ::PgComment::ConnectionAdapters::PostgreSQLAdapter
              end
            rescue
            end
          end
        end
      end
    end
  end
end
