module PgComment
  module ConnectionAdapters
    module PostgreSQLAdapter
      def supports_comments?
        true
      end

      def set_table_comment(table_name, comment)
        sql = "COMMENT ON TABLE #{quote_table_name(table_name)} IS $$#{comment}$$;"
        execute sql
      end

      def set_column_comment(table_name, column_name, comment)
        sql = "COMMENT ON COLUMN #{quote_table_name(table_name)}.#{quote_column_name(column_name)} IS $$#{comment}$$;"
        execute sql
      end

      def set_column_comments(table_name, comments)
        comments.each_pair do |column_name, comment|
          set_column_comment table_name, column_name, comment
        end
      end

      def remove_table_comment(table_name)
        sql = "COMMENT ON TABLE #{quote_table_name(table_name)} IS NULL;"
        execute sql
      end

      def remove_column_comment(table_name, column_name)
        sql = "COMMENT ON COLUMN #{quote_table_name(table_name)}.#{quote_column_name(column_name)} IS NULL;"
        execute sql
      end

      def remove_column_comments(table_name, *column_names)
        column_names.each do |column_name|
          remove_column_comment table_name, column_name
        end
      end

      def set_index_comment(index_name, comment)
        sql = "COMMENT ON INDEX #{quote_string(index_name)} IS $$#{comment}$$;"
        execute sql
      end

      def remove_index_comment(index_name)
        sql = "COMMENT ON INDEX #{quote_string(index_name)} IS NULL;"
        execute sql
      end

=begin
--Fetch all comments
SELECT c.relname as table_name, a.attname as column_name, d.description as comment
FROM pg_description d
JOIN pg_class c ON c.oid = d.objoid
LEFT OUTER JOIN pg_attribute a ON c.oid = a.attrelid AND a.attnum = d.objsubid
WHERE c.relkind = 'r'
ORDER BY c.relname
=end
      def comments(table_name)
        com = select_all %{
SELECT a.attname AS column_name, d.description AS comment
FROM pg_description d
JOIN pg_class c on c.oid = d.objoid
LEFT OUTER JOIN pg_attribute a ON c.oid = a.attrelid AND a.attnum = d.objsubid
WHERE c.relkind = 'r' AND c.relname = '#{table_name}'
                         }
        com.map do |row|
          [ row['column_name'], row['comment'] ]
        end
      end

      def index_comments
        com = select_all %{
SELECT c.relname AS index_name, d.description AS comment
FROM pg_description d
JOIN pg_class c ON c.oid = d.objoid
WHERE c.relkind = 'i'
ORDER BY index_name
                   }
        com.inject({}) do |hash, row|
          hash[row['index_name']] = row['comment']
          hash
        end
      end
    end
  end
end

[:PostgreSQLAdapter, :JdbcAdapter].each do |adapter|
  begin
    ActiveRecord::ConnectionAdapters.const_get(adapter).class_eval do
      include PgComment::ConnectionAdapters::PostgreSQLAdapter
    end
  rescue
  end
end