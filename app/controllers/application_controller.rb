class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  def admin_required
    if !current_user.admin?
      redirect_to root_path, alert: "你没有权限"
    end
  end

end
