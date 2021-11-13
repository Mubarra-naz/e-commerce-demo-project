class Coupon < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_coupons, against: [:name, :discount_type, :discount]

  has_and_belongs_to_many :categories

  CASH = 'cash'.freeze
  PERCENTAGE = 'percentage'.freeze
  TYPE = {cash: CASH, percentage: PERCENTAGE}.freeze

  enum discount_type: TYPE

  validates :name, presence: true, uniqueness: true
  validates :discount, presence: true, numericality: true
end
