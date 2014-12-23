class Activity < ActiveRecord::Base

  belongs_to :parent, :class_name => "Activity", :foreign_key => "parent_id"
  has_many :children, :class_name => "Activity", :foreign_key => "parent_id", :dependent => :destroy

  has_many :activity_items
  has_many :items, through: :activity_items, source: :product

  belongs_to :activity_type
  belongs_to :from_organization, class_name: "Organization"
  belongs_to :to_organization,   class_name: "Organization"

  belongs_to :owner, :class_name => "User", :foreign_key => "owner_user_id"

  validates :activity_type, :number, :from_organization, :to_organization, :owner, :presence => true

  def total_price
    leadChildren = children.joins(:type).where(:activity_types => { :name => "Lead" })

    if leadChildren.count < 1
      if activity_type.name == "Lead"
        return activity_items.sum(&:get_price)
      end

      return 0
    end

    return leadChildren.sum(&:total_price)
  end

  def type
    activity_type
  end

  def setTotalPrice
    self.total = getTotalPrice()

    self.save

    unless parent.nil?
      parent.setTotalPrice()
    end
  end
end
