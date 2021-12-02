module OrderHelper
  def total_price(line_item)
    line_item.product.price.to_i * line_item.quantity.to_i
  end
end
