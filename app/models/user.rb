class User < ApplicationRecord
  before_validation {email.downcase!}

  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, length: {minimum: 6}
  validates :password, presence: true

  has_secure_password
end
