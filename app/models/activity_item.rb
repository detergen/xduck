class ActivityItem < ActiveRecord::Base
  belongs_to :activity
  belongs_to :product

  validates :activity, :product, :quantity, :presence => true

  def get_price
    product ? product.get_sale_price * quantity : 0
  end

end
