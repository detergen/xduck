class Order < ActiveRecord::Base
  belongs_to :from_organization, :class_name => "Organization", :foreign_key => "from_organization_id"
  belongs_to :to_organization, :class_name => "Organization", :foreign_key => "to_organization_id"
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_user_id"
end
