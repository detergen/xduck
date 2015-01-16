# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :addr do
    contact

    name {Faker::Address.city}
    typeofaddr 'Work'
    postindex {Faker::Address.postcode}
    string1 {Faker::Address.street_address}
    string2 {Faker::Address.secondary_address}
    key "MyString"
    note "MyText"
  end
end
