class AddPriceToActivityItems < ActiveRecord::Migration
  def change
    add_column :activity_items, :price, :decimal
  end
end
