class Admin::AdminsController < ApplicationController
  before_action :authorize_admin

  protected

  def authorize_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
end
