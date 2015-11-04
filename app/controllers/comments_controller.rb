class CommentsController < ApplicationController
    def create
       @post = Post.find(params[:post_id])
       @comment = @post.comments.create(comment_params)
       @comment.user = current_user
       @comment.save
       redirect_to post_path(@comment.post)
     end

     def destroy
       @comment = Comment.find(params[:id])
       @comment.destroy
       redirect_to post_path(@comment.post)
     end

     def edit
       @post = Post.find(params[:post_id])
       @comment = Comment.find(params[:id])
     end

     def update
       @post = Post.find(params[:post_id])
       @comment = Comment.find(params[:id])
       if @comment.update(comment_params)
           redirect_to post_path(@post)
       else
           render 'edit'
       end
     end

     private
     def comment_params
       params.require(:comment).permit(:body)
     end
end
