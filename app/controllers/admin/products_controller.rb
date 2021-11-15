class Admin::ProductsController < Admin::AdminsController
  before_action :set_product, except: %i[index new create]

  def index
    respond_to do |format|
      format.html { @products = Product.search(helpers.sort_column, helpers.sort_direction, params[:page], params[:query]) }
      format.csv { send_data CsvProcessor.new(Product::CSV_HEADERS, 'Product').generate, filename: "products-#{Date.today}.csv" }
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "Created Product Successfully"
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Updated product Successfully"
    else
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
    params.require(:product).permit(:title, :description, :price, :status, :category_id, images: [])
  end
end
