class CreateActivityItems < ActiveRecord::Migration
  def up
    create_table :activity_items do |t|
      t.integer :activity_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end
  end

  def down
    drop_table :activity_items
  end
end
