class ActivityItem < ActiveRecord::Base
  belongs_to :activity
  belongs_to :product

  validates :product, :quantity, :presence => true
  validates :activity, presence: true, on: :update
  #def price
  #  product.sale_price
  #end

  def total_price
    price * quantity
  end

end
