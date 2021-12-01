class ProductsController < ApplicationController
  def index
    @products=Product.find_for_customers
  end
end
