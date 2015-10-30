class ActivityStatus < ActiveRecord::Base

  class << self

    def to_option
      all.map{|s| [s.name, s.id] }
    end

  end

end
