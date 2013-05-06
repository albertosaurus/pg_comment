module PgComment
  module Migration

    # PgComment methods for the migration command recorder.  This allows
    # comment methods to be used in "change" type migrations.
    module CommandRecorder

      def set_table_comment(*args) # :nodoc:
        record(:set_table_comment, args)
      end

      def remove_table_comment(*args) # :nodoc:
        record(:remove_table_comment, args)
      end

      def set_column_comment(*args) # :nodoc:
        record(:set_column_comment, args)
      end

      def set_column_comments(*args) # :nodoc:
        record(:set_column_comments, args)
      end

      def remove_column_comment(*args) # :nodoc:
        record(:remove_column_comment, args)
      end

      def remove_column_comments(*args) # :nodoc:
        record(:remove_column_comments, args)
      end

      def set_index_comment(*args) # :nodoc:
        record(:set_index_comment, args)
      end

      def remove_index_comment(*args) # :nodoc:
        record(:remove_index_comment, args)
      end

      # remove_table_comment
      def invert_set_table_comment(args)
        table_name = args.first
        [:remove_table_comment, [table_name]]
      end

      # remove_column_comment
      def invert_set_column_comment(args)
        table_name = args[0]
        column_name = args[1]
        [:remove_column_comment, [table_name, column_name]]
      end

      # remove_column_comments
      def invert_set_column_comments(args)
        i_args = [args[0]] + args[1].collect{|name, _| name  }
        [:remove_column_comments, i_args]
      end

      # remove_index_comment
      def invert_set_index_comment(args)
        index_name = args.first
        [:remove_index_comment, [index_name]]
      end
    end
  end
end