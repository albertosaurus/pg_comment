require 'spec_helper'

describe PgComment::ConnectionAdapters::SchemaDefinitions do
  class TableStub
    include ::PgComment::ConnectionAdapters::Table

    attr_reader :table_name, :base

    def initialize
      @table_name = :foo
      @base = OpenStruct.new
    end
  end

  let (:table_stub){ TableStub.new }

  it '.set_table_comment' do
    table_stub.base.should_receive(:set_table_comment).with(:foo, :bar)
    table_stub.set_table_comment :bar
  end

  it '.remove_table_comment' do
    table_stub.base.should_receive(:remove_table_comment).with(:foo)
    table_stub.remove_table_comment
  end

  it '.set_column_comment' do
    table_stub.base.should_receive(:set_column_comment).with(:foo, :bar, :baz)
    table_stub.set_column_comment(:bar, :baz)
  end

  it '.set_column_comments' do
    table_stub.base.should_receive(:set_column_comments).with(:foo, :bar)
    table_stub.set_column_comments(:bar)
  end

  it '.remove_column_comment' do
    table_stub.base.should_receive(:remove_column_comment).with(:foo, :bar)
    table_stub.remove_column_comment(:bar)
  end

  it '.remove_column_comments' do
    table_stub.base.should_receive(:remove_column_comments).with(:foo, :bar, :baz)
    table_stub.remove_column_comments(:bar, :baz)
  end
end