class OrdersController < ApplicationController
  include WithOrder

  def new
    @client_token = PaymentProcessor.generate_token
    @order = @user.orders.build(discount: 0, price: helpers.order_total(@cart.line_items))
    session[:order] = @order
  end

  def create
    session[:order]["payment_method"] = params[:payment_method]
    result = PlaceOrder.call(
      order_params: session[:order], payment_method_nonce: params[:nonce], items: @cart.line_items
    )

    if result.success?
      @cart.line_items.destroy_all
      redirect_to products_path, notice: "order placed successfully"
    else
      redirect_to new_user_order_path, error: result.error
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def set_cart
    @cart = @user.cart
  end
end
