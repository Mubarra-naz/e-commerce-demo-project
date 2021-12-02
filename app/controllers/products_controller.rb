class ProductsController < ApplicationController
  def index
    @products = Product.published
  end
end
