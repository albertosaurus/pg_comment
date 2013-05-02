require 'spec_helper'

describe 'Comments' do

  def connection
    ActiveRecord::Base.connection
  end

  def get_table_comment(table_name)
    connection.query(<<-SQL).flatten.first
      SELECT pg_desc.description
      FROM pg_catalog.pg_description pg_desc
        INNER JOIN pg_catalog.pg_class pg_class ON pg_class.oid = pg_desc.objoid
        INNER JOIN pg_namespace ON pg_class.relnamespace = pg_namespace.oid
      WHERE pg_class.relname = '#{table_name}'
        AND pg_desc.objsubid = 0  -- means table
    SQL
  end

  def get_column_comment(table_name, column)
    connection.query(<<-SQL).flatten.first
      SELECT d.description
      FROM pg_description d
        JOIN pg_class c on c.oid = d.objoid
        JOIN pg_attribute a ON c.oid = a.attrelid AND a.attnum = d.objsubid
        JOIN pg_namespace ON c.relnamespace = pg_namespace.oid
      WHERE c.relkind = 'r'
        AND c.relname = '#{table_name}'
        AND a.attname = '#{column}'
    SQL
  end

  it 'should create table comments' do
    get_table_comment('vegetables').should == 'Healthy and delicious'
  end

  it 'should create column comments' do
    get_column_comment('vegetables', 'name').should == 'The name of the vegetable'
    get_column_comment('vegetables', 'price').should == 'vegetable cost'
    get_column_comment('vegetables', 'comment').should == 'thoughts'
  end
end