class CreateTableTotals < ActiveRecord::Migration
  def change
    create_table :totals do |t|
      t.string :name
      t.string :expression
      t.boolean :is_active
      t.string :note
      t.integer :sort_order
    end
  end
end
