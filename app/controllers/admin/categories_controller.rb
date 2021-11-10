class Admin::CategoriesController < Admin::AdminsController
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.all
    end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "Created Category Successfully"
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Updated category Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Category deleted successfully"
    else
      flash[:error] = @category.errors.full_messages.to_sentence
    end

    redirect_to admin_categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
