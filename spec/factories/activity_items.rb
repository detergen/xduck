# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_item do
    product
    activity
    quantity { rand(1..20) }
  end
end
