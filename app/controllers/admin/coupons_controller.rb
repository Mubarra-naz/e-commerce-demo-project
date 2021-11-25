class Admin::CouponsController < Admin::AdminsController
  before_action :set_coupon, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html { @coupons = Coupon.search(helpers.sort_column, helpers.sort_direction, params[:page], params[:query]) }
      format.csv { send_data CsvProcessor.new(Coupon::CSV_HEADERS, 'Coupon').generate, filename: "coupons-#{Date.today}.csv" }
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
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_path, notice: "Updated coupon Successfully"
    else
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

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :discount, :discount_type, product_ids: [])
  end
end
