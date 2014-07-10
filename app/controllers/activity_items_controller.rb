class ActivityItemsController < ApplicationController
  before_action :authenticate_user!

  def delete
    if request.get?
      unless params[:id].nil?
        ActivityItem.destroy(params[:id])
      end
    end

    redirect_to request.referer
  end
end
