class PostsController < ApplicationController
  def index
      @posts = Post.all
  end

  def show
      @post = Post.find(params[:id])
  end

  def new
      @post = Post.new
  end

  def create
      @post = current_user.posts.new(post_params)
      if @post.save
          redirect_to '/'
      else
          render 'new'
      end
  end

  def destroy
      @post = Post.find(params[:id])
      if @post.destroy
          redirect_to '/'
      else
          render 'show'
      end
  end

  private
    def post_params
        params.require(:post).permit(:title, :link, :body, :category)
    end
end
