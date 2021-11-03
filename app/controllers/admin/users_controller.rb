class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :check_if_admin?

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_root_path
  end

  private

  def check_if_admin?
    redirect_to new_session_path unless current_user.role == User::ADMIN
  end
end
