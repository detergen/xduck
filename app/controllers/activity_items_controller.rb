class ActivityItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :activity

  def new
    @activity_item = activity.activity_items.build
  end

  def create
    @activity_item = activity.activity_items.build(permited_params)
    if @activity_item.save
      activity.recalculate_total
      redirect_to activity_path(activity)
    else
      render :new
    end
  end

  def edit
    @activity_item = activity.activity_items.find params[:id]
  end

  def update
    @activity_item = activity.activity_items.find params[:id]
    if @activity_item.update_attributes(permited_params)
      activity.recalculate_total
      redirect_to activity_path(activity)
    else
      render :edit
    end
  end

  def destroy
    activity.activity_items.find(params[:id]).delete
    activity.recalculate_total
    redirect_to activity_path(activity)
  end

  def activity
    @activity ||= Activity.find params[:activity_id]
  end

  def permited_params
    params.require(:activity_item).permit(:product_id, :quantity)
  end
end
