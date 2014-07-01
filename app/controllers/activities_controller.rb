class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def show
    if params[:parent_id].nil?
      @activities_grid = initialize_grid(Activity.where(
          :parent_id => nil),
        :include => [:from_organization, :to_organization, :owner, :type])
    else
      @activity = Activity.find_by :id => params[:parent_id]
      @activities_grid = initialize_grid(Activity.where(
          :parent_id => params[:parent_id]),
        :include => [:from_organization, :to_organization, :owner, :type])
    end
  end

  def add
    if request.get?
      @activity = Activity.new(:parent_id => params[:parent_id])
    end

    if request.post?
      @activity = Activity.new(activity_create_params)

      if @activity.activity_type_id.nil?
        activityType = ActivityType.find_by_name 'Lead'

        @activity.activity_type_id = activityType.id
      end

      if @activity.save
        redirect_to :action => 'show', :parent_id => @activity.parent_id
        return
      end
    end
  end

  def edit
    unless params[:id].nil?
      @activity = Activity.find_by :id => params[:id]
    else
      unless params[:activity][:id].nil?
        @activity = Activity.find_by :id => params[:activity][:id]

        if @activity.update(activity_update_params)
          redirect_to :action => 'show', :parent_id => @activity.parent_id
          return
        end
      end
    end
  end

  private
  def activity_update_params
    return params.require(:activity).permit(
        :id,
        :number,
        :activity_type_id,
        :from_organization_id,
        :to_organization_id,
        :date,
        :owner_user_id,
        :note,
        :tag)
  end

  private
  def activity_create_params
    return params.require(:activity).permit(
        :parent_id,
        :number,
        :activity_type_id,
        :from_organization_id,
        :to_organization_id,
        :date,
        :owner_user_id,
        :note,
        :tag)
  end
  
end
