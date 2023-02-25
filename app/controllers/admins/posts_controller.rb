class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
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
      redirect_to admins_post_path(@post.id)
    else
      @genres = Genre.all
      render :edit
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:genre_id, :name, :subject, :introduction, :is_active)
  end
  
end
