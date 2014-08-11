class CreateCurrency < ActiveRecord::Migration
  def up
    create_table :currencies do |t|
      t.string :code
      t.index :code, :unique => true
    end
  end

  def down
    drop_table :currencies
  end
end
