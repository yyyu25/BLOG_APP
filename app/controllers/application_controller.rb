class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # 登录后跳转到 posts 页面
  def after_sign_in_path_for(resource)
    posts_path
  end
end
