class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
    @posts = Post.order("id DESC").all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
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
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.user = current_user
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
