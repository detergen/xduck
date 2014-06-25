class ActivitiesController < ApplicationController
  def show
    @activities_grid
    if params[:parent_id].nil?
      @activities_grid = initialize_grid(Activity, :include => [:from_organization, :to_organization])
    else
      @activities_grid = initialize_grid(Activity.where(:parent_id => params[:parent_id]), :include => [:from_organization, :to_organization])
    end
  end

  def add
  end

  def edit
    @activity = Activity.find_by :id => params[:id]
  end
  
end
