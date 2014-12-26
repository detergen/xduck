FactoryGirl.define do
	factory :product do |f|
		sequence :name do |n|
			"Barrel#{n}"
		end
		sequence :articul do |n|
			"brl#{n}"
		end
	end
end
