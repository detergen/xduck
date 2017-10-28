class ActivityStatus < ActiveRecord::Base

  has_many :activity_statuses_relations

  class << self

    def to_option
      all.map{|s| [s.name, s.id] }
    end

  end

end
