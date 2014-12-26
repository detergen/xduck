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

  # если указана сумма внутри активити, берем ее,
  # иначе берем сумму по всем айтемам вложенным внее
  # с коэффициентом суммирования
  # и добавляем сюда сумму всех вложенных activity
  def total_price
    total = if price
              price
            else
              activity_items.includes(:product).map(&:get_price).sum
            end

    (total * sum_koef.to_i) + children.map(&:total_price).sum
  end

  def type
    activity_type
  end

  def calculate_price

  end

  def name
    "#{activity_type.name} #{number}"
  end

end
