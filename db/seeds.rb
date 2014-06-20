# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.find_by name: 'admin'
if role.nil? then
  role = Role.create(:name => 'admin', :resource_id => nil, :resource_type => nil)
  role.save or puts YAML::dump(role.errors)
end

user = User.find_by email: 'admin@xduck.local'
if user.nil? then
  user = User.create(:email => 'admin@xduck.local', :password => 'password')
  user.roles<<role
  user.save or puts YAML::dump(user.errors)
end

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
    
      organization.save
      
      test_orgs<<organization.id
    end
  end
end

for i in 1..30
  begin
    order = Order.find_by number: i.to_s + 'TST'
    if order.nil? then
      order = Order.create(
        :number => i.to_s + 'TST',
        :tag => 'test order',
        :note => 'test note',
        :owner_user_id => user.id,
        :from_organization_id => test_orgs[rand(0..4)],
        :to_organization_id => test_orgs[rand(0..4)])
      order.save
    end
  end
end
