class Admin::OrdersController < Admin::AdminsController
  def index
    @orders = Order.eager_load_associations
  end
end
