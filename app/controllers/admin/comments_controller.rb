class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:alert] = "已删除本评论"
    redirect_to admin_comments_path
  end

  def hide
    @comment = Comment.find(params[:id])
    @comment.hide!
    redirect_to admin_comments_path
  end

  def public
    @comment = Comment.find(params[:id])
    @comment.public!
    redirect_to admin_comments_path
  end

end
