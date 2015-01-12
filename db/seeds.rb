
#admin role
role = Role.find_by name: 'admin'
if role.nil?
  role = Role.create(:name => 'admin', :resource_id => nil, :resource_type => nil)
  role.save or puts YAML::dump(role.errors)
end

#default admin user
user = User.find_by email: 'admin@xduck.local'
if user.nil?
  user = User.create(:email => 'admin@xduck.local', :password => 'password')
  user.roles<<role
  user.save or puts YAML::dump(user.errors)
end

#currencies
rouble = Currency.find_by code: 'RUR'
if rouble.nil?
  rouble = Currency.create(:code => 'RUR')
  rouble.save or puts YAML::dump(rouble.errors)
end

euro = Currency.find_by_code 'EUR'
if euro.nil?
  euro = Currency.create(:code => 'EUR')
  euro.save or puts YAML::dump(euro.errors)
end

dollar = Currency.find_by code: 'USD'
if dollar.nil?
  dollar = Currency.create(:code => 'USD')
  dollar.save or puts YAML::dump(dollar.errors)
end


date_aug_11 = Date.parse('2014-08-11')

euro_to_rouble = ExchangeRate.find_by from_currency_id: euro.id, to_currency_id: rouble.id,  from_date: date_aug_11.beginning_of_day
if euro_to_rouble.nil?
  euro_to_rouble = ExchangeRate.create(:from_currency_id => euro.id, :to_currency_id => rouble.id, :from_date => date_aug_11.beginning_of_day, :exchange_rate => 48.2856)
  euro_to_rouble.save or puts YAML::dump(euro_to_rouble.save.errors)
end

dollar_to_rouble = ExchangeRate.find_by from_currency_id: dollar.id, to_currency_id: rouble.id, from_date: date_aug_11.beginning_of_day
if dollar_to_rouble.nil?
  dollar_to_rouble = ExchangeRate.create(:from_currency_id => dollar.id, :to_currency_id => rouble.id, :from_date => date_aug_11.beginning_of_day, :exchange_rate => 36.0475)
  dollar_to_rouble.save or puts YAML::dump(dollar_to_rouble.save.errors)
end

10.times do
  break if Organization.count >= 10
  FactoryGirl.create :organization
end

#activity types

20.times do
  FactoryGirl.create :product
end

["Order", "Lead", "Bill", "Shipping", "Assembly", "Payment", 'Log', 'Communication'].each do |type|
  unless ActivityType.find_by_name(type)
    ActivityType.create(name: type)
  end
end

10.times do
  parent_activity = FactoryGirl.create(:activity, owner: user)
  rand(1..7).times do
    FactoryGirl.create(:activity, :with_items, owner: user, parent: parent_activity)
  end
end
