class ChangeKeyColumns < ActiveRecord::Migration
  def change
    rename_column :addrs, :key, :address_key
    rename_column :contacts, :key, :contact_key
  end
end
