class Movie < ApplicationRecord
  has_many :ratings

  validates :title, presence: true, length: {maximum: 100}
  validates :plot, presence: true, length: {maximum: 10000}
  has_attached_file :poster, styles: { regular: "200x300>", thumb: "55x150>" }, default_url: "default_poster.png"
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\z/

end
