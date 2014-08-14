class ActivityItem < ActiveRecord::Base
  belongs_to :activity
  belongs_to :product

  validates :activity, :product, :quantity, :presence => true

  def getPrice
    unless product.nil?
      return product.getSalePrice() * quantity
    end

    return 0
  end
end
