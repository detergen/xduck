class AddActivityFields < ActiveRecord::Migration
  def change
    add_column :activities, :group_name, :string
    add_column :activities, :sort_name, :string
  end
end
