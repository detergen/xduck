class Bom < ActiveRecord::Base
#  attr_accessible :active, :group_id, :product_id, :qty, :subproduct_id

  belongs_to :product, :class_name => "Product"
  belongs_to :subproduct, :class_name => "Product"
end
