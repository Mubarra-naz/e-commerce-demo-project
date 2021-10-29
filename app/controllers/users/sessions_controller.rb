class Users::SessionsController < Devise::SessionsController

  def create
    if User.find_by_email(params[:user][:email]).present?
      if User.find_by_email(params[:user][:email]).try(:confirmed_at).present?
        super
      else
        redirect_to root_path, notice:  'Please confirm your email first'
      end
    else
      redirect_to root_path, notice:  'User not found'
    end
  end

end
