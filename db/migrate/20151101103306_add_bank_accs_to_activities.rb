class AddBankAccsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :to_bankacc_id, :integer
    add_column :activities, :from_bankacc_id, :integer
  end
end
