# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin role
role = Role.find_by name: 'admin'
if role.nil? then
  role = Role.create(:name => 'admin', :resource_id => nil, :resource_type => nil)
  role.save or puts YAML::dump(role.errors)
end

#default admin user
user = User.find_by email: 'admin@xduck.local'
if user.nil? then
  user = User.create(:email => 'admin@xduck.local', :password => 'password')
  user.roles<<role
  user.save or puts YAML::dump(user.errors)
end

#organizations
test_orgs = []

for i in 1..5
  begin
    organization = Organization.find_by :name => "Test organization #" + i.to_s
    
    if organization.nil? then
      organization = Organization.create(
        :name => "Test organization #" + i.to_s,
        :tag => "test org",
        :opf => "777",
        :short_name => "Test" + i.to_s,
        :full_name => "Test organization #" + i.to_s,
        :inn => "123",
        :kpp => "456",
        :ogrn => "789",
        :okpo => "900")
    
      organization.save or puts YAML::dump(organization.errors)
    end
    
    test_orgs << organization.id
  end
end

#activity types
test_activity_types = []

activity_types = ["Lead", "Bill", "Shipping", "Assembly", "Payment", 'Log', 'Communication']
for i in 0..(activity_types.length - 1)
  activity_type = ActivityType.find_by :name => activity_types[i]
  
  if activity_type.nil? then
    activity_type = ActivityType.create(:name => activity_types[i])
    
    activity_type.save or puts YAML::dump(activity_type.errors)
  end
  
  test_activity_types << activity_type.id
end

#root activities
test_activities = []

for i in 1..7
  begin
    activity = Activity.find_by number: i.to_s + 'TST'
    
    if activity.nil? then
      activity = Activity.create(
        #:parent_id => nil,
        :activity_type_id => test_activity_types[0],
        :number => i.to_s + 'TST',
        :tag => 'test root activity',
        :note => 'test note',
        :owner_user_id => user.id,
        :from_organization_id => test_orgs[rand(0..(test_orgs.length - 1))],
        :to_organization_id => test_orgs[rand(0..(test_orgs.length - 1))],
        :date => DateTime.now,
        :total => 0)
      
      activity.save or puts YAML::dump(activity.errors)
      
      test_activities << activity.id
    end
  end
end

#child activities
if test_activities.length > 0
  for i in 1..30
    begin
      activity = Activity.find_by number: i.to_s + 'TST_CH'

      if activity.nil? then
        activity = Activity.create(
            :parent_id => test_activities[rand(0..(test_activities.length - 1))],
            :activity_type_id => test_activity_types[rand(0..(test_activity_types.length - 1))],
            :number => i.to_s + 'TST_CH',
            :tag => 'test child activity',
            :note => 'test note',
            :owner_user_id => user.id,
            :from_organization_id => test_orgs[rand(0..(test_orgs.length - 1))],
            :to_organization_id => test_orgs[rand(0..(test_orgs.length - 1))],
            :date => DateTime.now,
            :total => 0)

        activity.save or puts YAML::dump(activity.errors)

        product = Product.first

        unless product.nil?
          for i in 1..3
            activity_item = ActivityItem.create(
                :activity_id => activity.id,
                :product_id => product.id,
                :quantity => 1
            )

            activity_item.save or puts YAML::dump(activity_item.errors)
          end
        end
      end
    end
  end
end

