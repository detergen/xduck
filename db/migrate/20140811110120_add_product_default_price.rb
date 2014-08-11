class AddProductDefaultPrice < ActiveRecord::Migration
  def up
    add_column :products, :purchase_currency_id, :integer
    add_column :products, :purchase_price, :decimal, :precision => 10, :scale => 2
    add_column :products, :sale_currency_id, :integer
    add_column :products, :sale_price, :decimal, :precision => 10, :scale => 2
  end

  def down
    remove_column :products, :sale_price
    remove_column :products, :sale_currency_id
    remove_column :products, :purchase_price
    remove_column :products, :purchase_currency_id
  end
end
