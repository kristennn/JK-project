class Account::PostsController < ApplicationController
  before_action :authenticate_user!
  layout 'user-center'
  def index
    @posts = current_user.posts
  end
end
