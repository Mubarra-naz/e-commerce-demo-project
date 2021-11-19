class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    attributes = %i[firstname lastname email username password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login, password, remember_me])
  end

  def after_sign_in_path_for(resource)
    return admin_users_path if resource.admin?

    user_path
  end
end
