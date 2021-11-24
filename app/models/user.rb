class User < ApplicationRecord
  extend Searchable
  include PgSearch::Model
  pg_search_scope :search_by_keys, against: %i[firstname lastname email id]

  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable, :confirmable

  has_one :cart, dependent: :destroy
  has_many :orders

  attr_accessor :login, :skip_password_validation

  USER = 'user'.freeze
  ADMIN = 'admin'.freeze
  ROLES = {user: USER, admin: ADMIN}.freeze
  CSV_HEADERS = %i[id full_name username email role confirmation_status].freeze

  enum role: ROLES, _default: USER

  validate :password_validation, if: :password_required?
  validates :firstname, :lastname, presence: true, format: { with: /^[a-zA-Z]{3,30}/, multiline: true, message: "should be either uppercase or lowercase alphabets only" }
  validates :username, uniqueness: true, presence: true, format: { with: /^(?=.*[a-z])|(?=.*[A-Z])|(?=.*[0-9])(?=.{3,30})/, multiline: true, message: "should be either uppercase, lowercase or numeric value" }

  before_save :set_invite_fields, if: :new_record?

  def login
    @login || username || email
  end

  def full_name
    "#{firstname} #{lastname}".titleize
  end

  def confirmation_status
    return "Confirmed" if confirmed_at.present?

    "Unconfirmed"
  end

  def created_by_invite?
    invitation_created_at?
  end

  def set_invitable_user
    self.invitation_created_at = Time.current
    self.skip_password_validation = true
    self.skip_confirmation!
  end

  private

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

  def set_invite_fields
    return unless created_by_invite?

    self.invitation_sent_at = Time.current
    self.password = SecureRandom.alphanumeric(9) + ["!","@","$","%"].join
  end

  def password_required?
    return false if skip_password_validation

    super
  end
end
