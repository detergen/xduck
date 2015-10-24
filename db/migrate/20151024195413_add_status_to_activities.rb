class AddStatusToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :status, :integer

    create_table :activity_statuses do |t|
      t.string :name
    end
  end
end
