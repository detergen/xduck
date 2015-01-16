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
    group_name { %w(Счета Отгрузки Другое).sample }
    sort_name 'date'
    sum_koef { [1, -1, 0].sample }

    factory :root_activity do
      activity_type { ActivityType.find_by_name('Order') }
      tag 'test root activity'
    end

    trait :with_items do
      after(:create) do |activity|
        create_list(:activity_item, rand(1..7), activity: activity)
        activity.recalculate_total
      end
    end

  end


end
