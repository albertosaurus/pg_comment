require 'spec_helper'

describe PgComment::Migration::CommandRecorder do
  class CommandRecorderStub
    include ::PgComment::Migration::CommandRecorder
  end

  let(:command_recorder_stub){ CommandRecorderStub.new }

  [ :set_table_comment,
    :remove_table_comment,
    :set_column_comment,
    :set_column_comments,
    :remove_column_comment,
    :remove_column_comments,
    :set_index_comment,
    :remove_index_comment ].each{ |method_name|

    it ".#{method_name}" do
      command_recorder_stub.should_receive(:record).with(method_name, [])
      command_recorder_stub.send(method_name)
    end
  }

  it '.invert_set_table_comment' do
    command_recorder_stub.invert_set_table_comment([:foo, :bar]).should == [:remove_table_comment, [:foo]]
  end

  it '.invert_set_column_comment' do
    command_recorder_stub.invert_set_column_comment([:foo, :bar, :baz]).should == [:remove_column_comment, [:foo, :bar]]
  end

  it '.invert_set_column_comments' do
    command_recorder_stub.invert_set_column_comments([:foo, {:bar => :baz}]).should == [:remove_column_comments, [:foo, :bar]]
  end

  it '.invert_set_index_comment' do
    command_recorder_stub.invert_set_index_comment([:foo, :bar]).should == [:remove_index_comment, [:foo]]
  end
end