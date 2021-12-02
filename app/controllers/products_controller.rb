class ProductsController < ApplicationController
  def index
    @products = Product.published
  end

  def show
    @product = Product.eager_load_search_associations.find(params[:id])
  end
end
