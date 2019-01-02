require_relative 'movie'
require_relative 'movie_collection'

file_path = ARGV[0] || 'movies.txt'

unless File.exist?(file_path)
  puts "No such file #{file_path}"
  exit 1
end

movies = MovieCollection.new(file_path)

puts "Check one movie: "
puts movies.all[0].to_s

puts "\nCheck first movie actors:"
puts movies.all.first.actors

puts "\nCheck first movie is Comedy:"
puts movies.all.first.has_genre?('Comedy')

puts "\nCheck first movie is Drama:"
puts movies.all.first.has_genre?('Drama')

puts "\nCheck all movies (first 5):"
puts movies.all.first(5)

puts "\nCheck movies sort (by date first 5 ):"
puts movies.movie_sort(:date).first(5)

puts "\nCheck movies filter (by genre first 5):"
puts movies.filter(:genre, 'Comedy').first(5)

puts "\nCheck movies statistic (by author):"
movies = movies.stats(:author)
movies.each do |author, movie_counter|
  puts "#{author} -- #{movies[author]}"
end
