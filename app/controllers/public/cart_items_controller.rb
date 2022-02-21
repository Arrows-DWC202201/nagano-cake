class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
    if @cart_item.present?
      @cart_item.quantity += params[:quantity].to_i
    else
      @cart_item = current_customer.carts_items.new.new(cart_item_params)
    end


    @cart_item.save
    redirect_to request.referer
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_item_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
