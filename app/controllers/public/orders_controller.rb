class Public::OrdersController < ApplicationController

  # before_action :authenticate_customer!
  # 管理者ログイン機能実装後使用

  def new
    @order = current_customer.orders.new
    @address = Address.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.item_id = cart_item.item_id
        order_item.order_id = @order.id
        order_item.quantity = cart_item.quantity
        order_item.tax_price = cart_item.item.price
        order_item.save
      end
      redirect_to thanks_orders_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_items = @order.order_items
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
      @delivery = current_customer.addresses.new(address_params)
      unless @delivery.save
        render :new
        return
      else
        @delivery
      end
    else
    end
    @order.set_receiver(receiver)
  end

  private

  def order_params
    params.require(:order).permit(:name, :payment_method, :postal_code, :address, :total_payment)
  end

  def address_params
    params.permit(:name,:address,:postal_code)
  end

end
