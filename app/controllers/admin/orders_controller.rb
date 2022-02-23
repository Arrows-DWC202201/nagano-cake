class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    # @orders = Order.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order.carriage = 800
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "注文ステータスの更新に成功しました"
    end
    redirect_to admin_order_path(@order)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
