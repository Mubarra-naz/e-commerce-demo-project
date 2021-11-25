class Admin::OrdersController < Admin::AdminsController
  def index
    @orders=Order.includes(:user)
  end
end
