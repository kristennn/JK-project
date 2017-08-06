class Account::PostsController < ApplicationController
  before_action :authenticate_user!
  layout 'user-center'
  
  def index
    @posts = current_user.posts
  end

  def edit
    @post = Post.find_by_friendly_id!(params[:id])
  end

  def destroy
    @post = Post.find_by_friendly_id!(params[:id])
    @post.destroy
    flash[:alert] = "已成功删除该文章"
    redirect_to :back
  end

end
