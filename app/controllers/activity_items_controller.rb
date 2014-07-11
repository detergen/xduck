class ActivityItemsController < ApplicationController
  before_action :authenticate_user!

  def add
    if request.get?
      unless params[:product_id].nil? && params[:quantity].nil?
        activity_item = ActivityItem.create(
            :product_id => params[:product_id],
            :quantity => params[:quantity]
        )

        activity_item.save()
      end
    end
  end

  def delete
    if request.get?
      unless params[:id].nil?
        ActivityItem.destroy(params[:id])
      end
    end

    redirect_to request.referer
  end
end
