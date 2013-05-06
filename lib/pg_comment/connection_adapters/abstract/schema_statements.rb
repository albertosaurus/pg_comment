module PgComment
  module ConnectionAdapters
    module SchemaStatements # :nodoc:
      def self.included(base) # :nodoc:
        base::AbstractAdapter.class_eval do
          include PgComment::ConnectionAdapters::AbstractAdapter
        end
      end
    end

    # PgComment method stubs for the abstract connection adapter
    module AbstractAdapter

      # Returns false (default use case)
      def supports_comments?
        false
      end

      # Sets a comment on the given table.
      #
      # ===== Example
      # ====== Creating a comment on phone_numbers table
      #  set_table_comment :phone_numbers, 'This table stores phone numbers that conform to the North American Numbering Plan.'
      def set_table_comment(table_name, comment)
        # Does nothing
      end

      # Sets a comment on a given column of a given table.
      #
      # ===== Example
      # ====== Creating a comment on npa column of table phone_numbers
      #  set_column_comment :phone_numbers, :npa, 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.'
      def set_column_comment(table_name, column_name, comment)
        # Does nothing
      end

      # Sets comments on multiple columns.  'comments' is a hash of column_name => comment pairs.
      #
      # ===== Example
      # ====== Setting comments on the columns of the phone_numbers table
      #  set_column_comments :phone_numbers, :npa => 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.',
      #                                      :nxx => 'Central Office Number'
      def set_column_comments(table_name, comments)

      end

      # Removes any comment from the given table.
      #
      # ===== Example
      # ====== Removing comment from phone numbers table
      #  remove_table_comment :phone_numbers
      def remove_table_comment(table_name)

      end

      # Removes any comment from the given column of a given table.
      #
      # ===== Example
      # ====== Removing comment from the npa column of table phone_numbers
      #  remove_column_comment :phone_numbers, :npa
      def remove_column_comment(table_name, column_name)
        
      end

      # Removes any comment from the given columns of a given table.
      #
      # ===== Example
      # ====== Removing comment from the npa and nxx columns of table phone_numbers
      #  remove_column_comments :phone_numbers, :npa, :nxx
      def remove_column_comments(table_name, *column_names)

      end

      # Sets the comment on the given index
      def set_index_comment(index_name, comment)

      end

      # Removes the comment from the given index
      def remove_index_comment(index_name)

      end

    end
  end
end