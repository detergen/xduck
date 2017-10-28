class CreateActivityStatusesRelation < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_statuses_relations do |t|
      t.integer :activity_id
      t.integer :activity_status_id

      t.datetime :created_at

      t.index :activity_id
      t.index :activity_status_id
    end
  end
end
