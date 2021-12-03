class UsersController < ApplicationController
  before_action :set_user

  def show; end

  def set_password; end

  def update_password
    if @user.update(user_params)
      bypass_sign_in @user, scope: :user
      redirect_to user_path, notice: "Updated password successfully"
    else
      render 'set_password'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :invitation_accepted_at)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
