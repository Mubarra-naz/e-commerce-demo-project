class LineItem < ApplicationRecord
  default_scope { includes(:product) }

  belongs_to :product
  belongs_to :cart
end
