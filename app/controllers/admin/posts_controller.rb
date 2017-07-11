class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"
  def index
    @posts = Post.all
  end

  def destroy
    @post = Post.find_by_friendly_id!(params[:id])
    @post.destroy
    flash[:alert] = "已删除文章。"
    redirect_to admin_posts_path
  end

  def hide
    @post = Post.find_by_friendly_id!(params[:id])
    @post.hide!
    redirect_to admin_posts_path
  end

  def public
    @post = Post.find_by_friendly_id!(params[:id])
    @post.public!
    redirect_to admin_posts_path
  end
end
