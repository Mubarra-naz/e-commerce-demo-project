class Admin::UsersController < Admin::AdminsController
  before_action :get_user, only: [:destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy ? flash[:notice] = "User deleted successfully" : flash[:error] = "An unexpected error has it occurred"

    redirect_to admin_root_path
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
