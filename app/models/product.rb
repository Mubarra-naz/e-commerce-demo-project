class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_products, against: [:title, :status, :id]

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
