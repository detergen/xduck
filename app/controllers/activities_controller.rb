class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def grouped?
    params[:grouped]
  end
  helper_method :grouped?

  def index
    @activities_grid = initialize_grid(Activity.where(parent_id: nil),
     include: [:from_organization, :to_organization, :owner, :activity_type, :activity_status],
     order: 'activities.date',
     order_direction: 'desc')
  end

  def show
    if grouped?
      @activities_grids =
          activity.children.group_by(&:activity_type).map{ |(key, values)|
            {
              name: key.name,
              total: values.sum(&:total_price),
              grid: initialize_grid(activity.children.where(activity_type: key),
                                    include: [:from_organization, :to_organization, :owner, :activity_type])
            }
          }
    else
      @activities_grid = initialize_grid(activity.children,
          include: [:from_organization, :to_organization, :owner, :activity_type])
      @activities_grids =
          activity.children.group_by(&:activity_type).map{ |(key, values)|
            {name: key.name, total: values.sum(&:total_price)}
          }
    end
    @activity_items_grid = initialize_grid(activity.activity_items, include: [:product])
  end

  def new
    if params[:duplicate_id]
      @activity = Activity.create_dup(params[:duplicate_id])
    elsif params[:parent_id]
      @activity = Activity.create_child(params[:parent_id])
    else
      @activity = Activity.new(activity_type: ActivityType.find_by_name('Order'), owner: current_user, sum_koef: 1, parent_id: params[:parent_id])
    end
    @activity_items_grid = initialize_grid(@activity.activity_items)
  end

  def create
    @activity = Activity.new(activity_create_params)
    if activity.save
      redirect_to activity_path(@activity)
    else
      puts @activity.errors.full_messages
      activity.activity_items.as_json
      @activity_items_grid = initialize_grid(activity.activity_items)
      render :new
    end
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

    activity.setTotalPrice()

    respond_to do |format|
      format.json  { render :json => { :result => !activity.errors.any?, :errors => activity.errors.full_messages } }
    end
  end

  def edit
    unless params[:id].nil?
      @activity = Activity.find_by :id => params[:id]
      @activity_items_grid = initialize_grid(ActivityItem.where(:activity_id => @activity.id), :include => [:product])
    end
  end

  def update
    activity.update(activity_update_params)
    redirect_to activity_path(activity)
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

      activity.setTotalPrice()
    end

    respond_to do |format|
      format.json  { render :json => { :result => !activity.errors.any?, :errors => activity.errors.full_messages } }
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

  def destroy
    activity.destroy
    redirect_to :back
  end

  def new_diff
    parent = Activity.find params[:parent_id]
    @activity = Activity.new(activity_type: ActivityType.find_by_name('Order'), owner: current_user, sum_koef: 1, parent_id: params[:parent_id], from_organization_id: parent.from_organization.id, to_organization_id: parent.to_organization.id )

    items = Activity.where(id: params[:ids]).reduce([]) do |items, activity|
      multiplier = if activity.activity_type_id == 1
                   1
                 elsif activity.activity_type_id == 4
                   -1
                 else
                   0
                 end
      activity.activity_items.each do |item|
        i = items.select{ |a| a.product_id == item.product_id }.first
        if i
          i.quantity = i.quantity + item.quantity * multiplier
          puts item.quantity * multiplier
        else
          item.quantity = item.quantity * multiplier
          items << item
          puts 'adding ' + item.as_json.to_s
          puts item.quantity
        end
      end
      items
    end

    items.map{ |a| a.activity_id = nil; a.id = nil; a}.each do |item|
      @activity.activity_items << item
    end

    puts items.count

    @activity_items_grid = initialize_grid(@activity.activity_items)

    render :new
  end

  private

  def activity
    @activity ||= Activity.find params[:id]
  end

  def activity_update_params
    params.require(:activity).permit(
        :id, :number, :activity_type_id, :from_organization_id, :to_organization_id,
        :date, :owner_user_id, :note, :to_bankacc_id, :from_bankacc_id,
        :tag, :sum_koef, :group_name, :activity_status_id, :sort_name)
  end

  def activity_create_params
    params.require(:activity).permit(
        :parent_id,
        :number,
        :activity_type_id,
        :from_organization_id,
        :to_organization_id,
        :date,
        :owner_user_id,
        :note,
        :tag,
        :group_name,
        :sum_koef,
        :sort_name,
        :activity_status_id, :to_bankacc_id, :from_bankacc_id,
        activity_items_attributes: [:product_id, :quantity])
  end

end
