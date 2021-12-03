class ProductsController < ApplicationController
  before_action :set_product, except: :index

  def index
    @products=Product.where(status: Product::PUBLISH)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
