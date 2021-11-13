class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_and_belongs_to_many :coupons

  validates :name, presence: true

  def titleize_name
    name.titleize
  end
end
