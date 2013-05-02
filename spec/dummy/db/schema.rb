# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130502030557) do

  create_table "vegetables", :force => true do |t|
    t.string  "name"
    t.decimal "price"
    t.string  "comment"
  end

  add_index "vegetables", ["name"], :name => "index_vegetables_on_name", :unique => true

  set_index_comment 'index_vegetables_on_name', 'Comment on index'
  set_table_comment 'vegetables', 'Healthy and delicious'
  set_column_comment 'vegetables', 'name', 'The name of the vegetable'
  set_column_comment 'vegetables', 'price', 'vegetable cost'
  set_column_comment 'vegetables', 'comment', 'thoughts'

  set_index_comment 'index_vegetables_on_name', 'Comment on index'
end
