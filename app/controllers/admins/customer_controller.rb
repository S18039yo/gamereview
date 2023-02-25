class Admins::CustomerController < ApplicationController
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admins_customer_path(@customer.id)
    else
      render :edit
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :email, :is_deleted)
  end
  
end
