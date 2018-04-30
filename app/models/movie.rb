class Movie < ApplicationRecord
  validates :title, presence: true, length: {maximum: 100}
  validates :plot, presence: true, length: {maximum: 10000}

end
