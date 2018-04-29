class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}

  before_save { self.email = email.downcase }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 100},
    format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: { minimum: 6 }
end
