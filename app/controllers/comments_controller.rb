class CommentsController < ApplicationController

  def new
    @post = Post.find_by_friendly_id!(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find_by_friendly_id!(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:note)
  end

end
