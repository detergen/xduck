class AddStatusToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :activity_status_id, :integer

    create_table :activity_statuses do |t|
      t.string :name
    end
  end
end
