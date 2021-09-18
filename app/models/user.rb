class User < ApplicationRecord
  before_validation {email.downcase!}

  validates :name, presence: true
  validates :email, presence: true,uniqueness: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: {minimum: 6}
  has_many :tasks, dependent: :delete_all

  has_secure_password
end
