class Coupon < ApplicationRecord
  extend Searchable
  include PgSearch::Model
  pg_search_scope :search_by_keys, against: %i[name discount_type discount]

  has_and_belongs_to_many :products

  CASH = 'cash'.freeze
  PERCENTAGE = 'percentage'.freeze
  TYPE = {cash: CASH, percentage: PERCENTAGE}.freeze
  CSV_HEADERS = %i[id name discount discount_type].freeze

  scope :eager_load_search_associations, -> { includes(:products) }

  enum discount_type: TYPE

  validates :name, presence: true, uniqueness: true
  validates :discount, presence: true, numericality: true

  def titleize_name
    name.titleize
  end
end
