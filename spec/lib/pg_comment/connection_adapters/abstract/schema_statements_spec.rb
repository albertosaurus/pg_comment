require 'spec_helper'

describe PgComment::ConnectionAdapters::AbstractAdapter do

  class AbstractAdapterStub
    include ::PgComment::ConnectionAdapters::AbstractAdapter
  end

  let(:adapter_stub){ AbstractAdapterStub.new }

  it 'should not support comments by default' do
    expect(adapter_stub.supports_comments?).to eq(false)
  end

  it 'should define method stubs for comment methods' do
    [ :set_table_comment,
      :set_column_comment,
      :set_column_comments,
      :remove_table_comment,
      :remove_column_comment,
      :remove_column_comments,
      :set_index_comment,
      :remove_index_comment ].each { |method_name| expect(adapter_stub.respond_to?(method_name)).to eq(true) }
  end
end
