class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: {with: /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})/, multiline:true}
  validates :firstname,:lastname,presence: true, format: {with: /^[a-zA-Z]{3,30}/, multiline:true }
  validates :firstname, uniqueness: { scope: :lastname, message: "Username not available" }
end
