class Activity < ActiveRecord::Base
  belongs_to :children, :class_name => "Activity", :foreign_key => "parent_id"
  belongs_to :type, :class_name => "ActivityType", :foreign_key => "activity_type_id"
  belongs_to :from_organization, :class_name => "Organization", :foreign_key => "from_organization_id"
  belongs_to :to_organization, :class_name => "Organization", :foreign_key => "to_organization_id"
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_user_id"
  
  validates :type, :number, :from_organization, :to_organization, :owner, :presence => true
end
