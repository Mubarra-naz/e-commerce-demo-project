class Admin::CouponsController < Admin::AdminsController
  include SortHelper

  before_action :set_coupon, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html { search_coupons }
      format.csv { export_csv }
    end
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to admin_coupons_path, notice: "Created Coupon Successfully"
    else
      flash.now[:notice]="Couldn't create"
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_path, notice: "Updated coupon Successfully"
    else
      flash.now[:notice]="Couldn't update."
      render 'edit'
    end
  end

  def destroy
    if @coupon.destroy
      flash[:notice] = "Coupon deleted successfully"
    else
      flash[:error] = @coupon.errors.full_messages.to_sentence
    end

    redirect_to admin_coupons_path
  end

  private

  def export_csv
    headers['Content-Disposition'] = "attachment; filename=\"coupon-list\""
    headers['Content-Type'] ||= 'text/csv'
  end

  def search_coupons
    if params[:search].present?
      @coupons = Coupon.all.search_coupons(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(5)
    else
      @coupons = Coupon.order(sort_column + " " + sort_direction).page(params[:page]).per(5)
    end
  end

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :discount, :discount_type, product_ids: [])
  end
end
