class Product < ApplicationRecord
  extend Searchable
  include PgSearch::Model
  pg_search_scope :search_by_keys, against: %i[title status id]

  has_rich_text :description

  PUBLISH = 'published'.freeze
  DRAFT = 'draft'.freeze
  PENDING = 'pending'.freeze
  STATUS = {published: PUBLISH, draft: DRAFT, pending: PENDING}.freeze
  CSV_HEADERS = %i[id title price status].freeze

  enum status: STATUS

  validates :title, presence: true
  validates :price, presence: true, numericality: true
  validates :description, length: { minimum: 15 }

  def titleized
    title.titleize
  end
end
