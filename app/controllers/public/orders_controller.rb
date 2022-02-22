class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.new
    @address = Address.new
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
  end

  def thanks
  end

  def confirm

  end

  private

  def order_params
    params.require(:order).permit(:name, :payment_method, :postal_code, :address, :total_payment)
  end

  def address_params
    params.permit(:name,:address,:postal_code)
  end

end
