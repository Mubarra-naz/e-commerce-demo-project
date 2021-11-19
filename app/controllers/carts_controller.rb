class CartsController < ApplicationController
  before_action :set_user, :set_cart

  def show; end

  def destroy
    if @cart.destroy
      flash[:notice] = "Cart was successfully destroyed."
    else
      flash[:error] = @cart.errors.full_messages.to_sentence
    end
    current_user.reload
    redirect_to products_path
  end

  private

  def set_user
    @user=User.find(current_user.id)
  end

  def set_cart
    if @user.cart.present?
      @cart = @user.cart
    else
      redirect_to products_path, notice: "Nothing in the cart"
    end
  end
end
