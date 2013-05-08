class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :articul
      t.boolean :active
      t.boolean :forsale
      t.text :note

      t.timestamps
    end
  end
end
