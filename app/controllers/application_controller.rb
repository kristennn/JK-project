class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      redirect_to root_path, alert: "你没有权限"
    end
  end

  private
  
   def configure_permitted_parameters
     added_params = [:name, :email, :password, :password_confirmation,:avatar]
     devise_parameter_sanitizer.permit :account_update, keys: added_params
   end

end
