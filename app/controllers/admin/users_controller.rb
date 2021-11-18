class Admin::UsersController < Admin::AdminsController
  include SortHelper

  before_action :set_user, except: :index

  def index
    respond_to do |format|
      format.html { @users = User.search(helpers.sort_column, helpers.sort_direction, params[:page], params[:query]) }
      format.csv { send_data CsvProcessor.new(User::CSV_HEADERS, 'User').generate, filename: "users-#{Date.today}.csv" }
    end
  end

  def show; end

  def edit; end

  def update
    if params.dig(:user, :password).blank?
      updated = @user.update_without_password(user_params.to_unsafe_hash)
    else
      updated = @user.update(user_params)
    end
    if updated
      redirect_to admin_users_path, notice: "Updated Successfully"
    else
      flash.now[:notice] = "Couldn't update."
      render 'edit'
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

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation)
  end
end
