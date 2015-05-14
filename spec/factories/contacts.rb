# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name Faker::Name.name
    short_name Faker::Name.first_name
    full_name "#{Faker::Name.first_name} #{Faker::Name.last_name}"
    to_name Faker::Name.first_name
    post "MyString"
    phone1 Faker::PhoneNumber.cell_phone
    phone2 Faker::PhoneNumber.cell_phone
    phone3 Faker::PhoneNumber.cell_phone
    phone4 Faker::PhoneNumber.cell_phone
    contact_key "MyString"
    tag "MyString"
    note "MyText"
    pasp_series Faker::Number.number(4)
    pasp_number Faker::Number.number(6)
    pasp_date Faker::Time.birthday
    pasp_given "MyString"
    pasp_kp "MyString"
    address Faker::Address.street_address
  end
end
