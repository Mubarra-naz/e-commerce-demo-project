class CartsController < ApplicationController
  before_action :set_cart

  def show; end

  def destroy
    if @cart.destroy
      flash[:notice] = "Cart was successfully destroyed."
    else
      flash[:error] = @cart.errors.full_messages.to_sentence
    end

    redirect_to products_path
  end

  private

  def set_cart
    @cart = current_user.cart

    redirect_to products_path, notice: "Nothing in the cart" unless @cart.present?
  end
end
