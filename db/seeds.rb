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
