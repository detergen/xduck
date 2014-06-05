class AddProductSizes < ActiveRecord::Migration
  def up
    add_column :products, :sizes, :string, :limit => 30
  end

  def down
    remove_column :products, :sizes
  end
end
