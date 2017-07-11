class CollectsController < ApplicationController
  before_action :authenticate_user!
  layout 'user-center'
  def index
    @posts = current_user.collected_posts
  end
end
