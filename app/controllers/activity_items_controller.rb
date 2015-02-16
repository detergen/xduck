class ActivityItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :activity

  load_and_authorize_resource

  def new
    @activity_item = activity.activity_items.build
  end

  def create
    @activity_item = activity.activity_items.build(activity_item_params)
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
    if @activity_item.update_attributes(activity_item_params)
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

  def activity_item_params
    params.require(:activity_item).permit(:product_id, :quantity, :price)
  end
end
