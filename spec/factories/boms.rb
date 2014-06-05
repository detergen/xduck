FactoryGirl.define do
  factory :bom do |f|
	  product 	{ |c| c.association(:product) }
	  subproduct { |c| c.association(:product) }
	  qty = 1
	  active = true
  end
end
