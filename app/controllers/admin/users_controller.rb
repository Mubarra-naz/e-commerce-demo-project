class Admin::UsersController < Admin::AdminsController
  include SortHelper

  before_action :set_user, only: :destroy

  def index
    respond_to do |format|
      format.html { @users = User.search(sort_column, sort_direction, params[:page], params[:query]) }
      format.csv { send_data CsvGenerator.new(%i[id full_name username email role confirmation_status], 'User').file_generator, filename: "user-#{Date.today}.csv" }
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
