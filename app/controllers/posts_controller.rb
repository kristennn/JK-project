class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
    @posts = Post.order("id DESC").all
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end


  def edit
    @post = Post.find[params[:id]]
    @post.user = current.user
  end

  def update
    @post = Post.find(params[:id])
    @post.user = current_user
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.user = current_user
  end

  def collect
    @post = Post.find(params[:id])
    current_user.collected_posts << @post
    flash[:notice] = "成功收藏本翻译"
    redirect_to :back
  end

  def uncollect
    @post = Post.find(params[:id])
    current_user.collected_posts.destroy(@post)
    flash[:alert] = "已经取消收藏本翻译"
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
