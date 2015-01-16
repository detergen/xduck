FactoryGirl.define do
  factory :product do |f|
	  sequence :name do |n|
      "Barrel#{n}"
    end
    sequence :articul do |n|
      "brl#{n}"
    end
    sale_currency { Currency.first }
    purchase_currency { Currency.first }
    sale_price { rand(10..1000) }
    note 'temp'
    active true
    purchase_price { sale_price * rand(0.1..0.9) }
  end
end
