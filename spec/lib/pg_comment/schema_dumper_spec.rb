require 'spec_helper'

describe ActiveRecord::SchemaDumper do
  before(:all) do
    stream = StringIO.new
    ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream)
    @dump = stream.string
  end

  it 'dumps table comments' do
    @dump.should =~ /set_table_comment 'vegetables', 'Healthy and delicious'/
  end

  it 'dumps column comments' do
    @dump.should =~ /set_column_comment 'vegetables', 'name', 'The name of the vegetable'/
    @dump.should =~ /set_column_comment 'vegetables', 'price', 'vegetable cost'/
    @dump.should =~ /set_column_comment 'vegetables', 'comment', 'thoughts'/
  end
end