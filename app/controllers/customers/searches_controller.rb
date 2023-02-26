class Customers::SearchesController < ApplicationController
  before_action :authenticate_customer!
  
  def search
    @range = params[:range]

    if @range == "ゲームタイトル"
      @posts = Post.looks(params[:search], params[:word]).where(is_active: "true")
    else
      @posts = Post.where(genre_id: Genre.where("name LIKE?","%#{params["word"]}%").ids).where(is_active: "true")
    end
  end
  
end
