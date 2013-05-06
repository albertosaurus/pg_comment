module PgComment
  module ConnectionAdapters
    module SchemaDefinitions # :nodoc:
      def self.included(base) # :nodoc:
        base::Table.class_eval do
          include PgComment::ConnectionAdapters::Table
        end
      end
    end

    # Extensions to ActiveRecord::ConnectionAdapters::Table
    module Table
      extend ActiveSupport::Concern

      # Sets the comment on the table
      #
      # ===== Example
      # ====== Set comment on table
      #   t.set_table_comment 'This table stores phone numbers that conform to the North American Numbering Plan.'
      def set_table_comment(comment)
        @base.set_table_comment(@table_name, comment)
      end

      # Removes any comment from the table
      #
      # ===== Example
      # ====== Remove table comment
      #   t.remove_table_comment
      def remove_table_comment
        @base.remove_table_comment(@table_name)
      end

      # Sets the comment for a given column
      #
      # ===== Example
      # ====== Set comment on the npa column
      #   t.set_column_comment :npa, 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.'
      def set_column_comment(column_name, comment)
        @base.set_column_comment(@table_name, column_name, comment)
      end

      # Sets comments on multiple columns.  'comments' is a hash of column_name => comment pairs.
      #
      # ===== Example
      # ====== Setting comments on the columns of the phone_numbers table
      #  t.set_column_comments :npa => 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.',
      #                        :nxx => 'Central Office Number'
      def set_column_comments(comments)
        @base.set_column_comments(@table_name, comments)
      end

      # Removes any comment for a given column
      #
      # ===== Example
      # ====== Remove comment from the npa column
      #   t.remove_column_comment :npa
      def remove_column_comment(column_name)
        @base.remove_column_comment(@table_name, column_name)
      end

      # Removes any comments from the given columns
      #
      # ===== Example
      # ====== Remove comment from the npa and nxx columns
      #   t.remove_column_comment :npa, :nxx
      def remove_column_comments(*column_names)
        @base.remove_column_comments(@table_name, *column_names)
      end
    end
  end
end