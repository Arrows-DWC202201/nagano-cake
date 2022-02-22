class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @genre = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genre = Genre.all
  end
end
