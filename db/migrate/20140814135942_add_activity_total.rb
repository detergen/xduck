class AddActivityTotal < ActiveRecord::Migration
  def up
    change_column :activities, :total, :decimal
  end

  def down
    change_column :activities, :total, :float
  end
end
