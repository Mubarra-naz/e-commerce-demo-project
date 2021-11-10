class Admin::ProductsController < Admin::AdminsController
  before_action :set_product, except: [:index, :new, :create]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "Created Product Successfully"
    else
      flash.now[:notice]="Couldn't create"
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
  if @product.update(product_params)
    redirect_to admin_products_path, notice: "Updated product Successfully"
    else
      flash.now[:notice]="Couldn't update."
      render 'edit'
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "Product deleted successfully"
    else
      flash[:error] = @product.errors.full_messages.to_sentence
    end

    redirect_to admin_products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :status)
  end
end
