class AddPriceToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :price, :decimal
  end
end
