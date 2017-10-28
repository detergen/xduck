class ActivityStatusesRelation < ActiveRecord::Base

  belongs_to :activity
  belongs_to :activity_status

  validates_uniqueness_of :activity_status_id, scope: :activity_id

end
