class ActivityItem < ActiveRecord::Base
  belongs_to :activity
  belongs_to :product

  validates :activity, :product, :quantity, :presence => true
end
