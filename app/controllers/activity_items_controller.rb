class ActivityItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :activity

  load_and_authorize_resource

  def new
    @activity_item = activity.activity_items.build
    @products_grid = initialize_grid(Product.all, :order => 'products.name')
  end

  def create
    if activity.activity_items.create(create_activity_item_params)
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
    if @activity_item.update_attributes(edit_activity_item_params)
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

  def destroy_checked
    activity_item_ids = params[:grid][:selected]
    activity.activity_items.where(id: activity_item_ids).delete_all
    redirect_to activity_path(activity)
  end

  def activity
    @activity ||= Activity.find params[:activity_id]
  end

  def create_activity_item_params
    params[:grid][:selected].map do |product_id|
      {
        product_id: product_id.to_i,
        quantity: params[:grid][:activity_item][product_id][:quantity].to_i,
        price: get_item_price(product_id)
      }
    end
  end

  def edit_activity_item_params
    params.require(:activity_item).permit(:product_id, :quantity, :price)
  end

  def get_item_price(product_id)
    ActivityItem.joins(:activity).
      where(product_id: product_id).
      where('activities.to_organization_id' => activity.to_organization_id).
      recent.first.try(:price) || Product.find(product_id).try(:price)
  end

end
