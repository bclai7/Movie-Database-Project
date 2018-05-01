class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates :comment, presence: true
  validates :rating_value, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 10}
end
