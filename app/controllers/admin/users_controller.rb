class Admin::UsersController < Admin::AdminsController
  before_action :set_user, except: %i[index new create]

  def index
    @model_name= 'User'
    respond_to do |format|
      format.html { @users = User.search(helpers.sort_column, helpers.sort_direction, params[:page], params[:query]) }
      format.csv { send_data CsvProcessor.new(User::CSV_HEADERS, 'User').generate, filename: "users-#{Date.today}.csv" }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.invitation_created_at = Time.current
    @user.skip_password_validation = true
    @user.skip_confirmation!

    if @user.save
      InvitationMailer.with(user: @user).invitations_instructions.deliver_now
      redirect_to admin_users_path, notice: "Invitation sent to user"
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if updated?
      redirect_to admin_users_path, notice: "Updated Successfully"
    else
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

  def updated?
    return @user.update_without_password(user_params) if params.dig(:user, :password).blank?

    @user.update(user_params)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation)
  end
end
