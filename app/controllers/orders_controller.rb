class OrdersController < ApplicationController
  def show
    @orders_grid
    if params[:owner_id].nil?
      @orders_grid = initialize_grid(Order, :include => [:from_organization, :to_organization, :owner])
    else
      @orders_grid = initialize_grid(Order.where(:owner_user_id => params[:owner_id]), :include => [:from_organization, :to_organization, :owner])
    end
  end
  
  def edit
    @order = Order.find_by :id => params[:id]
  end
end
