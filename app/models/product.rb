class Product < ApplicationRecord
  has_rich_text :description

  PUBLISH = 'published'.freeze
  DRAFT = 'draft'.freeze
  PENDING = 'pending'.freeze
  STATUS = {published: PUBLISH, draft: DRAFT, pending: PENDING}.freeze

  enum status: STATUS

  validates :title, presence: true
  validates :price, presence: true, numericality: true
  validates :description, length: { minimum: 15 }

end
