# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name {Faker::Company.name}
    tag {Faker::Company.suffix}
    opf {Faker::Company.ein}
    short_name {Faker::Company.suffix}
    full_name {Faker::Company.name}
    inn {Faker::Code.isbn}
    kpp {Faker::Code.ean}
    ogrn {Faker::Company.ein}
    okpo {Faker::Company.duns_number}

    after(:create) do |organization|
      create(:user)
      create(:bankacc, organization: organization)
      contacts = create_list(:contact, 2, organization: organization)
      contacts.each do |c|
        create_list(:addr, 2, organization: organization, contact: c)
      end
    end
  end
end
