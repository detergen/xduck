class ActivityItem < ActiveRecord::Base
  belongs_to :activity
  belongs_to :product

  validates :product, :quantity, :presence => true
  validates :activity, presence: true, on: :update
  #def price
  #  product.sale_price
  #end

  before_create :set_price


  def total_price
    price.to_i * quantity
  end

  def set_price
    self.price = product.sale_price if self.price.to_i == 0
  end

end
