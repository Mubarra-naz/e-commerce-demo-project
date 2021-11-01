class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable

  validate :password_validation
  validates :firstname,:lastname, presence: true, format: { with: /^[a-zA-Z]{3,30}/, multiline: true, message: "should be either uppercase or lowercase alphabets only" }
  validates :username, uniqueness: true, presence: true, format: { with: /^(?=.*[a-z])|(?=.*[A-Z])|(?=.*[0-9])(?=.{3,30})/, multiline: true, message: "should be either uppercase, lowercase or numeric value" }

  private
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
