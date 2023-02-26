class Customers::CustomerController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]
  before_action :is_matching_login_customer, only: [:edit, :update]
  
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @bookmarks = @customer.bookmarks
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end
  
  def unsubscribe
    @customer = current_customer
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :email)
  end
  
  # アクセス制限
  def is_matching_login_customer
    customer_id = params[:id].to_i
    unless customer_id == current_customer.id
      redirect_to customer_path(current_customer)
    end
  end
  
  # ゲストアカウントの制限
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.last_name == "閲覧"
      redirect_to customer_path(current_customer)
    end
  end  
  
end
