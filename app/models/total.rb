class Total < ActiveRecord::Base

  scope :active, -> { where(is_active: true) }

  def value(activity)
    activity.instance_eval(expression)
  rescue Exception
    0
  end

end
