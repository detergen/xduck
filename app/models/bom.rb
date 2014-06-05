class Bom < ActiveRecord::Base
<<<<<<< HEAD
  #attr_accessible :active, :group_id, :product_id, :qty, :subproduct_id
=======
  attr_accessible :active, :group_id, :product_id, :qty, :subproduct_id
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450

  belongs_to :product, :class_name => "Product"
  belongs_to :subproduct, :class_name => "Product"
end
