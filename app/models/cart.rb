class Cart < ApplicationRecord
  default_scope { includes(:line_items) }

  belongs_to :user

  has_many :line_items, dependent: :destroy

  def add_item(product)
    item = line_items.find_by(product_id: product.id)

    if item.present?
      item.increment(:quantity)
    else
      item = line_items.build(product_id: product.id)
    end

    item
  end
end
