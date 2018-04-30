class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :plot
      t.string :poster_path
      t.date :release_date
      t.float :avg_rating

      t.timestamps
    end
  end
end
