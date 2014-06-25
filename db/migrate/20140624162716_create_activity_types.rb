class CreateActivityTypes < ActiveRecord::Migration
  def up
    create_table :activity_types do |t|
      t.string :name
    end
  end
  
  def down
    drop_table :activity_types
  end
end
