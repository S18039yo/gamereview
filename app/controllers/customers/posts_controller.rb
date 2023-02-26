class Customers::PostsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @posts = Post.all.where(is_active: "true")
  end
  
  def new
    @customer = current_customer
    @post = Post.new
    @genres = Genre.all
    @post.is_active = true
  end
  
  def create
    @post = Post.new(post_params)
    @post.customer = current_customer
    if @post.save
      redirect_to post_path(@post.id)
    else
      @genres = Genre.all
      render :new
    end
  end
  
  def show
    # ゲストログイン機能制限
    # @customerがあるため@customersとしています
    @customers = current_customer
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_comment = PostComment.new
  end
  
  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @post = Post.find(params[:id])
    @genres = Genre.all
    if @post.update(post_params)
      redirect_to customer_path(current_customer)
    else
      @genres = Genre.all
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to customer_path(current_customer)
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:genre_id, :name, :subject, :introduction, :is_active)
  end
  
end
