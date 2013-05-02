class CreateVegetables < ActiveRecord::Migration
  def change
    create_table :vegetables do |t|
      t.string :name
      t.decimal :price
      t.string :comment
    end

    set_table_comment :vegetables, 'Healthy'

    set_column_comment :vegetables, :name, 'The name of the vegetable'

    set_column_comments :vegetables, :price => 'vegetable cost', :comment => 'thoughts'

    change_table :vegetables do |t|
      t.set_table_comment 'Healthy and delicious'
    end
  end
end
