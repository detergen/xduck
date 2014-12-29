# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bankacc do
    name {Faker::Address.city}
    full_name {Faker::Address.street_address}
    ks {Faker::Company.duns_number}
    rs {Faker::Company.ein}
    bik {Faker::Code.ean}
  end
end
