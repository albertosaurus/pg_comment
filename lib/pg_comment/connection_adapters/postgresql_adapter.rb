module PgComment
  module ConnectionAdapters

    # Implementation of the comment methods
    module PostgreSQLAdapter

      # Returns +true+, Postgres supports comments
      def supports_comments?
        true
      end

      # Sets a comment on the given table.
      #
      # ===== Example
      # ====== Creating a comment on phone_numbers table
      #  set_table_comment :phone_numbers, 'This table stores phone numbers that conform to the North American Numbering Plan.'
      #
      # @param [String, Symbol] table_name
      # @param [String, Symbol] comment
      def set_table_comment(table_name, comment)
        sql = "COMMENT ON TABLE #{quote_table_name(table_name)} IS $$#{comment}$$;"
        execute sql
      end

      # Sets a comment on a given column of a given table.
      #
      # ===== Example
      # ====== Creating a comment on npa column of table phone_numbers
      #  set_column_comment :phone_numbers, :npa, 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.'
      #
      # @param [String, Symbol] table_name
      # @param [String, Symbol] column_name
      # @param [String, Symbol] comment
      def set_column_comment(table_name, column_name, comment)
        sql = "COMMENT ON COLUMN #{quote_table_name(table_name)}.#{quote_column_name(column_name)} IS $$#{comment}$$;"
        execute sql
      end

      # Sets comments on multiple columns.  'comments' is a hash of column_name => comment pairs.
      #
      # ===== Example
      # ====== Setting comments on the columns of the phone_numbers table
      #  set_column_comments :phone_numbers, :npa => 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.',
      #                                      :nxx => 'Central Office Number'
      #
      # @param [String, Symbol] table_name
      # @param [Hash<Symbol, String>] comments
      def set_column_comments(table_name, comments)
        comments.each_pair do |column_name, comment|
          set_column_comment table_name, column_name, comment
        end
      end

      # Removes any comment from the given table.
      #
      # ===== Example
      # ====== Removing comment from phone numbers table
      #  remove_table_comment :phone_numbers
      #
      # @param [String, Symbol] table_name
      def remove_table_comment(table_name)
        sql = "COMMENT ON TABLE #{quote_table_name(table_name)} IS NULL;"
        execute sql
      end

      # Removes any comment from the given column of a given table.
      #
      # ===== Example
      # ====== Removing comment from the npa column of table phone_numbers
      #  remove_column_comment :phone_numbers, :npa
      #
      # @param [String, Symbol] table_name
      # @param [String, Symbol] column_name
      def remove_column_comment(table_name, column_name)
        sql = "COMMENT ON COLUMN #{quote_table_name(table_name)}.#{quote_column_name(column_name)} IS NULL;"
        execute sql
      end

      # Removes any comment from the given columns of a given table.
      #
      # ===== Example
      # ====== Removing comment from the npa and nxx columns of table phone_numbers
      #  remove_column_comments :phone_numbers, :npa, :nxx
      #
      # @param [String, Symbol] table_name
      # @param [*String] column_names
      def remove_column_comments(table_name, *column_names)
        column_names.each do |column_name|
          remove_column_comment table_name, column_name
        end
      end

      # Sets the comment on the given index
      #
      # @param [String, Symbol] index_name
      # @param [String, Symbol] comment
      def set_index_comment(index_name, comment)
        sql = "COMMENT ON INDEX #{quote_string(index_name)} IS $$#{comment}$$;"
        execute sql
      end

      # Removes the comment from the given index
      #
      # @param [String, Symbol] index_name
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

      # Loads the comments for the given table from the database
      # @param [String, Symbol] table_name
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

      # Loads index comments from the database
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
