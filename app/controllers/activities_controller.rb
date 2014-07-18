class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def show
    @activity = Activity.find_by :id => params[:parent_id]
    @activities_grid = initialize_grid(Activity.where(
      :parent_id => params[:parent_id]),
      :include => [:from_organization, :to_organization, :owner, :type])
  end

  def add
    @activity = Activity.new(:parent_id => params[:parent_id])
    @activity_items_grid = initialize_grid(@activity.activity_items)
  end

  def ajax_add
    activity = Activity.new(activity_create_params)

    activity.save

    unless params[:added_activity_items].nil?
      params[:added_activity_items].each do |key, value|
        activity_item = ActivityItem.create(
            :activity_id => activity.id,
            :product_id => value[:product_id].to_i,
            :quantity => value[:quantity].to_i
        )

        activity_item.save()
      end
    end

    respond_to do |format|
      format.json  { render :json => true }
    end
  end

  def edit
    unless params[:id].nil?
      @activity = Activity.find_by :id => params[:id]
      @activity_items_grid = initialize_grid(ActivityItem.where(:activity_id => @activity.id), :include => [:product])
    end
  end

  def ajax_edit
    unless params[:activity][:id].nil?
      activity = Activity.find_by :id => params[:activity][:id]

      activity.update(activity_update_params)

      unless params[:added_activity_items].nil?
        params[:added_activity_items].each do |key, value|
          activity_item = ActivityItem.create(
              :activity_id => activity.id,
              :product_id => value[:product_id].to_i,
              :quantity => value[:quantity].to_i
          )

          activity_item.save()
        end
      end

      unless params[:deleted_activity_items].nil?
        ActivityItem.destroy(params[:deleted_activity_items])
      end
    end

    respond_to do |format|
      format.json  { render :json => true }
    end
  end

  def delete
    success = false

    if request.get?
      unless params[:id].nil?
        Activity.destroy(params[:id])

        success = true
      end

      respond_to do |format|
        format.html { redirect_to(request.referer) }
        format.json  { render :json => success }
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
