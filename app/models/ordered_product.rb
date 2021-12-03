class OrderedProduct < ApplicationRecord
  scope :eager_load_associations, -> { includes(:product) }

  belongs_to :product
  belongs_to :order
end
