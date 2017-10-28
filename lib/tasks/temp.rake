# coding: utf-8
namespace :temp do

  task :migrate_activity_statuses => :environment do
    Activity.find_each do |activity|
      if activity.activity_status
        activity.activity_statuses << activity.activity_status
      end
    end
  end

end
