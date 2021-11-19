class User < ApplicationRecord
  extend Searchable
  include PgSearch::Model
  pg_search_scope :search_by_keys, against: %i[firstname lastname email id]

  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable, :confirmable

  attr_writer :login

  USER = 'user'.freeze
  ADMIN = 'admin'.freeze
  ROLES = {user: USER, admin: ADMIN}.freeze
  CSV_HEADERS = %i[id full_name username email role confirmation_status]

  enum role: ROLES

  validate :password_validation
  validates :firstname, :lastname, presence: true, format: { with: /^[a-zA-Z]{3,30}/, multiline: true, message: "should be either uppercase or lowercase alphabets only" }
  validates :username, uniqueness: true, presence: true, format: { with: /^(?=.*[a-z])|(?=.*[A-Z])|(?=.*[0-9])(?=.{3,30})/, multiline: true, message: "should be either uppercase, lowercase or numeric value" }

  after_initialize :set_default_role, if: :new_record?

  def login
    @login || username || email
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def confirmation_status
    return "Confirmed" if confirmed_at.present?

    "Unconfirmed"
  end

  private

  def set_default_role
    self.role ||= USER
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    users = where(conditions)
    return users.find_by(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]) if login
    return users.first if conditions[:username].blank?

    find_by(username: conditions[:username])
  end

  def password_validation
    rules = {
      'must contain at least one lowercase letter'  => /[a-z]+/,
      'must contain at least one uppercase letter'  => /[A-Z]+/,
      'must contain at least one digit'             => /\d+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add :password, message unless password.match(regex)
    end
  end
end
