class Admin::UsersController < Admin::AdminsController
  before_action :set_user, only: :destroy

  def index
    respond_to do |format|
      format.html do
        if params[:search].present?
          @users = User.search_by_keys(params[:search]).page(params[:page]).per(5)
        else
          @users = User.all.page(params[:page]).per(5)
        end
      end

      format.csv do
        @users=User.all
        headers['Content-Disposition'] = "attachment; filename=\"user-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
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
