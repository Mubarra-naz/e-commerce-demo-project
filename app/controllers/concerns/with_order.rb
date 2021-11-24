module WithOrder
  extend ActiveSupport::Concern

  included do
    before_action :set_user, :set_cart, except: [:states, :cities]
  end

  def add_coupon
    @coupon = Coupon.find_by_name(params[:coupon_code])
    if @coupon
      session[:order]["discount"] = Discount.new(@cart.line_items, @coupon).calculate_order_discount
      session[:order]["price"] = session[:order]["price"].to_i - session[:order]["discount"].to_i
      flash.now[:notice] = "applied coupon"
    else
      flash.now[:error] = "invalid coupon code"
    end
    respond_to do |f|
      f.js
    end
  end

  def update_user
    @user=User.find(current_user.id)
    if @user.update_without_password(user_params)
      flash.now[:notice] = "Customer information updated successfully"
    else
      flash.now[:error] = @user.errors.full_messages
    end
    respond_to do |f|
      f.js
    end
  end

  def states
    render json: CS.states(params[:country]).to_json
  end

  def cities
    render json: CS.cities(params[:state], params[:country]).to_json
  end

  private

  def user_params
    params.require(:user).permit(:phone, :zip_code, :address, :country, :city, :state, :firstname, :lastname, :email)
  end
end
