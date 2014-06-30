class ActivitiesController < ApplicationController
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
  end

  def edit
    unless params[:id].nil?
      @activity = Activity.find_by :id => params[:id]
    else
      unless params[:activity][:id].nil?
        activity = Activity.find_by :id => params[:activity][:id]

        if activity.update(activity_update_params)
          redirect_to :action => 'show', :parent_id => activity.parent_id
          return
        end

        redirect_to :action => 'edit', :id => activity.id
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
  
end
