class Admin::UsersController < Admin::AdminsController
  before_action :set_user, only: :destroy

  def index
    if params[:search].present?
      @users = User.search_by_keys(params[:search])
    else
      @users = User.all
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "User deleted successfully"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end

    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
