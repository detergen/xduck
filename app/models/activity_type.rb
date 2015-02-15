class ActivityType < ActiveRecord::Base

  TYPE_NAMES = ["Order", "Lead", "Bill", "Shipping", "Assembly", "Payment", 'Log', 'Communication']

end
