class PostsController < ApplicationController

  def index
      @posts = Post.all.order("created_at DESC")
  end

  def show
      @post = Post.find(params[:id])
      @comments = @post.comments.all
      @comment = Comment.new
  end

  def new
      if current_user
          @post = Post.new
      else
          redirect_to '/'
      end
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

  def upvote
      @post = Post.find(params[:id])
      @post.upvote_by current_user
      redirect_to :back
  end

  def downvote
      @post = Post.find(params[:id])
      @post.downvote_by current_user
      redirect_to :back
  end

  private
    def post_params
        params.require(:post).permit(:title, :link, :body, :category)
    end
end
