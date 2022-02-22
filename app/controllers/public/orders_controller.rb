class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.new
    @address = Address.new
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order.carriage = 800
  end

  def thanks
  end

  def confirm
    @order = current_customer.orders.new
    @order.payment_method = params[:payment_method]
    @order.carriage = 800
    @order.total_payment = current_customer.cart_items_total_price + @order.carriage

    receiver =
    case @address_type = params[:address_type].to_i
    when 1
      current_customer
    when 2
      current_customer.addresses.find(params[:address_id])
    when 3
      @address = current_customer.addresses.new(address_params)
      unless @address.save
        flash[:alert] = '住所が正しくありません'
        render :new
        return
      else
        @address
      end
    else
    end
    @order.set_receiver(receiver)
  end

  def create
    current_customer.orders.create(order_params)
    redirect_to complete_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:name, :payment_method, :postal_code, :address, :total_payment)
  end

  def address_params
    params.permit(:name,:address,:postal_code)
  end

  def check_cart_is_not_empty
    redirect_to items_path unless current_customer.cart_items.present?
  end

end
