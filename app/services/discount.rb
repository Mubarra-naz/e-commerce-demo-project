class Discount
  attr_accessor :items, :coupon
  def initialize(line_items, coupon)
    self.items = line_items
    self.coupon = coupon
  end
  def find_coupon_discount(product)
    if coupon.products.include? product
      return coupon.discount if coupon.discount_type == Coupon::CASH

      product.price * coupon.discount/100
    else
      0
    end
  end

  def calculate_order_discount
    items.to_a.sum { |item| find_coupon_discount(item.product).to_i * item.quantity.to_i }
  end
end
