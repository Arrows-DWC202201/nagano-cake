class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @customer = current_customer
    @addresses = Address.where(customer_id: @customer.id)
  end

  def new
    @address = Address.new
  end


  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      @customer = current_customer
      @addresses = Address.where(customer_id: @customer.id)
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
    if @address.customer == current_customer
      render :edit
    else
      redirect_to address_path
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    if address.destroy
      redirect_to addresses_path
    else
      render :index
    end
  end



  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
