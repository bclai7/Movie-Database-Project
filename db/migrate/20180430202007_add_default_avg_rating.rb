class AddDefaultAvgRating < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :avg_rating, :float, :default => 0.0
  end
end
