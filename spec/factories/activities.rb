# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    association :owner, factory: :user
    activity_type { ActivityType.all.sample }
    tag 'test activity'
    note 'test note'
    number {"TST #{Faker::Number.number(6)}"}
    association :from_organization, factory: :organization
    association :to_organization, factory: :organization
    date {Date.today}

    factory :root_activity do
      activity_type { ActivityType.find_by_name('Order') }
      tag 'test root activity'
    end

    factory :root_activity do
      association :parent, factory: :activity
    end

  end


end
