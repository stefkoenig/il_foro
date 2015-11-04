class PostsController < ApplicationController
  def index
      @posts = Post.all
  end

  def show
      @post = Post.find(params[:id])
      @comments = @post.comments.all
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

  def edit
      @post = Post.find(params[:id])
  end

  def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
          redirect_to '/'
      else
          render 'edit'
      end
  end

  private
    def post_params
        params.require(:post).permit(:title, :link, :body, :category)
    end
end
