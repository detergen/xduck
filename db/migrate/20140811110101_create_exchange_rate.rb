class CreateExchangeRate < ActiveRecord::Migration
  def up
    create_table :exchange_rates do |t|
      t.integer :from_currency_id, :null => false
      t.integer :to_currency_id, :null => false
      t.decimal :exchange_rate, :precision => 10, :scale => 4
      t.datetime :from_date
      t.datetime :to_date
    end
  end
 
  def down
    drop_table :exchange_rates
  end
end
