class LineItemsController < ApplicationController
  before_action :set_line_item, except: :create
  before_action :set_cart, only: :create

  def create
    @product = Product.find(params[:product_id])
    @line_item = @cart.add_item(@product)

    if @line_item.save
      redirect_to products_path, notice: 'Item successfully added to cart.'
    else
      render :new
    end
  end

  def destroy
    if @line_item.destroy
      flash[:notice] = "Item was successfully removed."
    else
      flash[:error] = @line_item.errors.full_messages.to_sentence
    end

    redirect_to user_cart_path
  end

  def update_quantity
    if @line_item.update(quantity: params[:qty])
      render json: { line_item: @line_item }
    else
      render json: { errors: @line_item.errors.full_messages }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def set_cart
    @cart = current_user.cart.present? || current_user.create_cart
  end
end
