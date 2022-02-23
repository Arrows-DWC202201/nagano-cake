class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
       flash[:notice] = "製作ステータスの更新に成功しました"
    end
    redirect_to admin_order_path(@order_item.order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:make_status)
  end
end
