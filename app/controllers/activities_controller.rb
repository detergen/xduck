class ActivitiesController < ApplicationController
  def show
    @activities_grid
    if params[:parent_id].nil?
      @activities_grid = initialize_grid(Activity, :include => [:from_organization, :to_organization])
    else
      @activity = Activity.find_by :id => params[:parent_id]
      @allow_activity_editing = false
      @activities_grid = initialize_grid(Activity.where(:parent_id => params[:parent_id]), :include => [:from_organization, :to_organization])
    end
  end

  def add
  end

  def edit
    @activity = Activity.find_by :id => params[:id]
    @allow_activity_editing = true
  end
  
end
