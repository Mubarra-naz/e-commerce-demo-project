class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = [:firstname, :lastname, :email, :username, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :remember_me])
  end

  def after_sign_in_path_for(resource)
    byebug
    return admin_root_path if resource.role == User::ADMIN
    edit_user_registration_path
  end
end
