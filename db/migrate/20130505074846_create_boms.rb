class CreateBoms < ActiveRecord::Migration
  def change
    create_table :boms do |t|
      t.integer :product_id
      t.integer :subproduct_id
      t.integer :group_id
      t.decimal :qty
      t.boolean :active

      t.timestamps
    end
  end
end
