class User < ApplicationRecord
  # Validation for user. Required field with max length of 50
  validates :name, presence: true, length: {maximum: 50}

  # Before saving email to database, convert to lowecase so it is easier to compare
  before_save { self.email = email.downcase }
  # Regular expression for detecting valid email addresses
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # Validation for email. Required field, max length of 100, assure it is in
  # the format of an email address using the RegEx, assures uniqueness within DB
  validates :email, presence: true, length: {maximum: 100},
    format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  # Set and authenticate passwords using Bcrypt hashing
  has_secure_password
  # Pasword length a minimum of 6 characters
  validates :password, length: { minimum: 6 }
end
