class Order < ApplicationRecord
  has_many :ordered_products, dependent: :destroy

  belongs_to :user

  ONLINE = 'online'.freeze
  CASH = 'cash'.freeze
  PAYMENT_METHOD = {online: ONLINE, cash: CASH}.freeze

  enum payment_method: PAYMENT_METHOD

  scope :eager_load_associations, -> { includes(:user, ordered_products: [:product]) }

  def add_items(items)
    items.each do |item|
      ordered_products.create( quantity: item.quantity, product: item.product )
    end
  end
end
