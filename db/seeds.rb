# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'movies.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  m = Movie.new
  if row['original_title']
    m.title = row['original_title']
  end
  if row['overview']
    m.plot = row['overview']
  end
  if row['release_date']
    m.release_date = row['release_date']
  end
  if row['poster_path']
    m.poster_file_name = "http://image.tmdb.org/t/p/w185" + row['poster_path']
  end
  m.save
end
puts csv_text

(0..10000).each do |i|
	u=User.new
  u.name="User"+i.to_s
  u.email="User"+i.to_s+"@email.com"
  u.password="aaaaaa"
  u.save
end

@rating_values = [1,2,3,4,5,6,7,8,9,10]
@comments = ["Terrible Movie...", "Bad Movie", "Not very good", "Not a good movie",
            "Could be better", "Decent Movie", "Not bad", "Good Movie", "Great Movie!",
            "Excellent Movie!!!"]

(0..42000).each do |i|
  (0..10000).each do |j|
  	r=Rating.new
    @rate=Random.new.rand(1..10)
    r.rating_value=@rating_values[@rate]
    r.comment = @comments[@rate]
    r.movie_id=i
    r.user_id=j
    r.save
  end
end
