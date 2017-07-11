class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy, :collect, :uncollect, :hate]
  before_action :validate_search_key, only: [:search]

  def search
    if @query_string.present?
      @posts = search_params
    end
  end

  def index
    @comment = Comment.new
    if params[:category].blank?
      @posts = Post.where(is_hidden: false).order("id DESC").paginate(:page => params[:page], :per_page => 5)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(:category_id => @category_id).paginate(:page => params[:page], :per_page => 5)
    end
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      @categories = Category.all
      render :new
    end
  end

  def show
    @post = Post.find_by_friendly_id!(params[:id])
    @comments = @post.comments
  end


  def edit
    @post = Post.find_by_friendly_id!(params[:id])
    @post.user = current.user
    @categories = Category.all
  end

  def update
    @post = Post.find_by_friendly_id!(params[:id])
    @post.user = current_user
    if @post.update(post_params)
      redirect_to posts_path
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_friendly_id!(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def collect
    @post = Post.find_by_friendly_id!(params[:id])
    current_user.collected_posts << @post
    flash[:notice] = "成功收藏本翻译"
    redirect_to :back
  end

  def uncollect
    @post = Post.find_by_friendly_id!(params[:id])
    current_user.collected_posts.destroy(@post)
    flash[:alert] = "已经取消收藏本翻译"
    redirect_to :back
  end

  def like
    @post = Post.find_by_friendly_id!(params[:id])
    unless @post.find_like(current_user)
      Like.create( :user => current_user, :post => @post)
    end
    flash[:notice] = "点赞成功"
    redirect_to posts_path
  end

  def unlike
    @post = Post.find_by_friendly_id!(params[:id])
    @like = @post.find_like(current_user)
    @like.destroy
    flash[:notice] = "已取消赞"
    redirect_to posts_path
  end

  def hate
    @post = Post.find_by_friendly_id!(params[:id])
    unless @post.find_hate(current_user)
      Hate.create( :user => current_user, :post => @post)
    end
    flash[:alert] = "你已鄙视它"
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :title, :link, :metacontent, :is_hidden, :category_id )
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "")if params[:q].present?
  end


  def search_params
    Post.ransack({:title_or_content_cont => @query_string}).result(distinct: true)
  end
end
