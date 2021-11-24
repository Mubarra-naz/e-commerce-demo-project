module OrderHelper
  def total_price(line_item)
    line_item.product.price.to_i * line_item.quantity.to_i
  end

  def order_total(line_items)
    line_items.to_a.sum { |item| total_price(item) }
  end
end
