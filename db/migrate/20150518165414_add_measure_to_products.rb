class AddMeasureToProducts < ActiveRecord::Migration
  def change
    add_column :products, :measure, :string
  end
end
