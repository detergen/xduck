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
    @activity = Activity.find_by :id => params[:id]
  end
  
end
