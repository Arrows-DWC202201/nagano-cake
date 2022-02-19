class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
    if @user == current_customer
      render :edit
    else
      redirect_to customers_path(current_customer.id)
    end
  end

  def update
    @customer = Costomer.find(params[:id])
    if @user.update(user_params)
      redirect_to customers_path(@customer.id)
    else
      render :edit
    end
  end

  def quit
  end

  def out
  end

end
