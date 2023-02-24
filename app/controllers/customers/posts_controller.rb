class Customers::PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
    @genres = Genre.all
    @post.is_active = true
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post.id)
    else
      @genres = Genre.all
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
    @genre = Genre.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @post = Post.find(params[:id])
    @genres = Genre.all
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
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
