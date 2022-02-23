class Admin::OrdersController < ApplicationController

  # before_action :authenticate_admin!
  # 管理者ログイン/ログアウト作成後使用

  def index
    # @orders = Order.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order.carriage = 800
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
