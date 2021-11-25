class Api::V1::ProductsController < Api::V1::ApiController
  before_action :set_product, except: [:index, :create]
  before_action :set_products, only: [:index, :destroy]

  def index;
    render json: @products
  end

  def create
    @product = Product.create(product_params)
    render json: @product
  end

  def show;
    render json: @product
  end

  def update
    @product.update(product_params)
    render json: @product
  end

  def destroy
    @product.destroy
    render json: @products
  end

  private


  def set_products
    @products = Product.all
  end


  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:id, :title, :description, :price, :status, :category_id, images: [])
  end
end
