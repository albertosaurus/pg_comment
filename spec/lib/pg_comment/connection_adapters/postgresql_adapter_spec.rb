require 'spec_helper'

describe PgComment::ConnectionAdapters::PostgreSQLAdapter do

  class ConnectionStub
    include ::PgComment::ConnectionAdapters::PostgreSQLAdapter

    def quote_table_name(name)
      "\"#{name}\""
    end

    alias_method :quote_column_name, :quote_table_name
    alias_method :quote_string, :quote_table_name
  end

  let(:connection){ ConnectionStub.new }

  it 'should support comments' do
    connection.supports_comments?.should be_true
  end

  context 'comment methods' do
    it '.set_table_comment' do
      connection.should_receive(:execute).with("COMMENT ON TABLE \"foo\" IS $$bar$$;")
      connection.set_table_comment :foo, :bar
    end

    it '.set_column_comment' do
      connection.should_receive(:execute).with("COMMENT ON COLUMN \"foo\".\"bar\" IS $$baz$$;")
      connection.set_column_comment :foo, :bar, :baz
    end

    it '.set_column_comments' do
      connection.should_receive(:execute).with("COMMENT ON COLUMN \"foo\".\"bar\" IS $$baz$$;")
      connection.set_column_comments :foo, :bar => :baz
    end

    it '.remove_table_comment' do
      connection.should_receive(:execute).with("COMMENT ON TABLE \"foo\" IS NULL;")
      connection.remove_table_comment :foo
    end

    it '.remove_column_comment' do
      connection.should_receive(:execute).with("COMMENT ON COLUMN \"foo\".\"bar\" IS NULL;")
      connection.remove_column_comment :foo, :bar
    end

    it '.remove_column_comments' do
      connection.should_receive(:execute).with("COMMENT ON COLUMN \"foo\".\"bar\" IS NULL;")
      connection.remove_column_comments :foo, :bar
    end

    it '.set_index_comment' do
      connection.should_receive(:execute).with("COMMENT ON INDEX \"foo\" IS $$bar$$;")
      connection.set_index_comment :foo, :bar
    end

    it '.remove_index_comment' do
      connection.should_receive(:execute).with("COMMENT ON INDEX \"foo\" IS NULL;")
      connection.remove_index_comment :foo
    end
  end
end