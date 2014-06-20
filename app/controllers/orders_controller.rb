class OrdersController < ApplicationController
  def show
    @orders
    if params[:id].nil?
      @orders = Order.all
    else
      @orders = Order.find_by id: params[:id]
    end
  end
end
