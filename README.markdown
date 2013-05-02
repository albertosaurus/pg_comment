# PgComment

https://github.com/albertosaurus/pg_comment

[![Build Status](https://travis-ci.org/albertosaurus/pg_comment.png)](https://travis-ci.org/albertosaurus/pg_comment)

In any PostgreSQL database where the Rails app is not the only consumer, it is very helpful to have comments
on the various elements of the schema.  PgComment extends the migrations DSL with methods to set and remove
comments on columns, tables and indexes.  It also dumps those comments into your schema.rb.

Obviously, only the PostgreSQL adapter (ether 'pg' or 'activerecord-jdbcpostgresql-adapter')
is supported.  All bug reports are welcome.

## Requirements

* Ruby 1.8.7, Ruby 1.9.2, Ruby 1.9.3, JRuby 1.6+
* ActiveRecord 3.0, 3.1, 3.2

## Installation

Add the following to the Gemfile of your Rails app:

    gem 'pg_comment'

then run

    bundle install

Alternatively you can manually install from RubyGems:

    gem install pg_comment

## Usage

PgComment adds eight methods to the migrations DSL:

* `set_table_comment(table_name, comment)`
* `remove_table_comment(table_name)`
* `set_column_comment(table_name, column_name, comment)`
* `remove_column_comment(table_name, column_name, comment)`
* `set_column_comments(table_name, column_comment_hash)`
* `remove_column_comments(table_name, *column_names)`
* `set_index_comment(index_name, comment)`
* `remove_index_comment(index_name)`

### Examples

```ruby
# Set a comment on the given table.
set_table_comment :phone_numbers, 'This table stores phone numbers that conform to the North American Numbering Plan.'

# Sets a comment on a given column of a given table.
set_column_comment :phone_numbers, :npa, 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.'

# Removes any comment from the given table.
remove_table_comment :phone_numbers

# Removes any comment from the given column of a given table.
remove_column_comment :phone_numbers, :npa

# Set comments on multiple columns in the table.
set_column_comments :phone_numbers,
                    :npa => 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.',
                    :nxx => 'Central Office Number'

# Remove comments from multiple columns in the table.
remove_column_comments :phone_numbers, :npa, :nxx

# Set a comment on an index
set_index_comment :index_phone_numbers_on_npa, 'Unique index on area code'

# Remove a comment from an index
remove_index_comment :index_phone_numbers_on_npa
```

PgComment also adds extra methods to `change_table`.

```ruby
# Set comments:
change_table :phone_numbers do |t|
  t.set_table_comment 'This table stores phone numbers that conform to the North American Numbering Plan.'
  t.set_column_comment :npa, 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.'
end

change_table :phone_numbers do |t|
  t.set_column_comments :npa => 'Numbering Plan Area Code - Allowed ranges: [2-9] for first digit, [0-9] for second and third digit.',
                        :nxx => 'Central Office Number'
end

# Remove comments:
change_table :phone_numbers do |t|
  t.remove_table_comment
  t.remove_column_comment :npa
end

change_table :phone_numbers do |t|
  t.remove_column_comments :npa, :nxx
end
```

## License

Copyright (c) 2011-2013 Arthur Shagall, Mindflight, Inc.

Released under the MIT License.  See LICENSE for details.