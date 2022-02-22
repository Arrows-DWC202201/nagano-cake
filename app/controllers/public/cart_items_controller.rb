class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
    if @cart_item.present?
      @cart_item.quantity += params[:quantity].to_i
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
    end

    if @cart_item.quantity.nil?
      flash[:alert] = '数量を選択して下さい'
      redirect_to request.referer
    elsif  @cart_item.save
      redirect_to cart_items_path, notice: '商品を追加しました'
    else
      flash[:alert] = '商品を追加できませんでした'
      redirect_to request.referer
    end

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
    params.permit(:item_id, :quantity)
  end
end
