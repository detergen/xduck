class Activity < ActiveRecord::Base

  belongs_to :parent, :class_name => "Activity", :foreign_key => "parent_id"
  has_many :children, :class_name => "Activity", :foreign_key => "parent_id", :dependent => :destroy

  has_many :activity_items
  has_many :items, through: :activity_items, source: :product

  belongs_to :activity_status
  belongs_to :activity_type
  belongs_to :from_organization, class_name: "Organization"
  belongs_to :to_organization, class_name: "Organization"
  belongs_to :to_bankacc, class_name: "Bankacc"
  belongs_to :from_bankacc, class_name: "Bankacc"

  belongs_to :owner, :class_name => "User", :foreign_key => "owner_user_id"

  validates :activity_type, :number, :from_organization, :to_organization, :sum_koef, :owner, :presence => true

  accepts_nested_attributes_for :activity_items

  scope :orders,    -> { where(activity_type_id: 1) }
  scope :leads,     -> { where(activity_type_id: 2) }
  scope :shippings, -> { where(activity_type_id: 4) }
  scope :payments,  -> { where(activity_type_id: 6) }

  after_create :recalculate_total

  before_destroy :delete_children

  # если указана сумма внутри активити, берем ее,
  # иначе берем сумму по всем айтемам вложенным внее
  # с коэффициентом суммирования
  # и добавляем сюда сумму всех вложенных activity

  def total_price
    if parent?
      children.map(&:total_price).sum
    else
      total.to_f * sum_koef.to_i
    end
  end

  def total_vat
    total.to_f / 118.0 * 18.0
  end

  def type
    activity_type
  end

  def calculate_price

  end

  def name
    "#{activity_type.name} #{number}"
  end

  # в преположении что у нас только 2 уровня
  def child?
    !!parent_id
  end

  def parent?
    !parent_id
  end

  def recalculate_total
    self.total = activity_items.includes(:product).map(&:total_price).sum
    save
  end

  def delete_children
    children.each(&:destroy)
    activity_items.each(&:destroy)
  end

  def orders_sum
    children.orders.map(&:total_price).sum.to_f
  end

  def shipping_sum
    children.shippings.map(&:total_price).sum.to_f
  end

  def payments_sum
    children.payments.map(&:total_price).sum.to_f
  end


  class << self
    def create_dup(origin_id)
      origin = find(origin_id)
      child = origin.dup
      origin.activity_items.map do |item|
        child.activity_items << item.dup
      end
      child
    end
  end
end
