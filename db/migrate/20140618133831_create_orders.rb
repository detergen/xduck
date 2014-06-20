class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.integer :from_organization_id
      t.integer :to_organization_id
      t.integer :owner_user_id
      t.string :note
      t.string :tag
      
      t.timestamps
    end
  end
end
