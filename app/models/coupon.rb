class Coupon < ApplicationRecord

  CASH = 'cash'.freeze
  PERCENTAGE = 'percentage'.freeze
  TYPE = {cash: CASH, percentage: PERCENTAGE}.freeze

  enum discount_type: TYPE

  validates :name, presence: true, uniqueness: true
  validates :discount, presence: true, numericality: true
end
