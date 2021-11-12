class Product < ApplicationRecord
  extend Searchable
  include PgSearch::Model
  pg_search_scope :search_by_keys, against: %i[title status id]

  belongs_to :category, optional: true

  belongs_to :category

  has_rich_text :description
  has_and_belongs_to_many :coupons
  has_many_attached :images
  has_many :line_items, dependent: :destroy
  has_many :ordered_products, dependent: :restrict_with_error

  PUBLISH = 'published'.freeze
  DRAFT = 'draft'.freeze
  PENDING = 'pending'.freeze
  DEACTIVATED = 'deactivated'.freeze
  STATUS = {published: PUBLISH, draft: DRAFT, pending: PENDING, deactivated: DEACTIVATED}.freeze
  CSV_HEADERS = %i[id title price status].freeze

  scope :eager_load_search_associations, -> { includes(:category) }

  enum status: STATUS

  validates :title, presence: true
  validates :price, presence: true, numericality: true
  validates :description, length: { minimum: 15 }
  validates :status, presence: true

  def titleize_title
    title.titleize
  end
end
