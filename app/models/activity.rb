class Activity < ActiveRecord::Base
  belongs_to :parent, :class_name => "Activity", :foreign_key => "parent_id"
  has_many :children, :class_name => "Activity", :foreign_key => "parent_id", :dependent => :destroy
  has_many :activity_items, :class_name => "ActivityItem", :foreign_key => "activity_id", :dependent => :destroy
  belongs_to :type, :class_name => "ActivityType", :foreign_key => "activity_type_id"
  belongs_to :from_organization, :class_name => "Organization", :foreign_key => "from_organization_id"
  belongs_to :to_organization, :class_name => "Organization", :foreign_key => "to_organization_id"
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_user_id"
  
  validates :type, :number, :from_organization, :to_organization, :owner, :presence => true

  def getTotalPrice
    leadChildren = children.joins(:type).where(:activity_types => { :name => "Lead" })

    if leadChildren.count < 1
      if type.name == "Lead"
        return activity_items.map { |ai| ai.getPrice() }.sum
      end

      return 0
    end

    return leadChildren.map { |c| c.getTotalPrice() }.sum
  end

  def setTotalPrice
    self.total = getTotalPrice()

    self.save

    unless parent.nil?
      parent.setTotalPrice()
    end
  end
end
