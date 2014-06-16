# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :addr do
    name "MyString"
    typeofaddr "MyString"
    postindex "MyString"
    string1 "MyString"
    string2 "MyString"
    key "MyString"
    note "MyText"
    organization_id 1
    contact_id 1
  end
end
