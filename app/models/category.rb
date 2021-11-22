class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true

  def titleize_name
    name.titleize
  end
end
