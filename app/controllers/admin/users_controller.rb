class Admin::UsersController < Admin::AdminsController
  include SortHelper

  before_action :set_user, only: :destroy

  def index
    respond_to do |format|
      format.html do
        if params[:search].present?
          @users = User.search_by_keys(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(5)
        else
          @users = User.order(sort_column + " " + sort_direction).page(params[:page]).per(5)
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
