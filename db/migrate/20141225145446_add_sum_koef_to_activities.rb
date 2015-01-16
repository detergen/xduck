class AddSumKoefToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :sum_koef, :integer
  end
end
