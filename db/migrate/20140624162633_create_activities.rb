class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.integer :parent_id
      t.integer :activity_type_id
      t.string :number
      t.integer :from_organization_id
      t.integer :to_organization_id
      t.date :date
      t.integer :owner_user_id
      t.float :total
      t.string :note
      t.string :tag
      
      t.timestamps
    end
  end
  
  def down
    drop_table :activities
  end
end
