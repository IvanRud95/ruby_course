require_relative 'movie_collection'
require_relative 'movie'
require_relative 'netflix'
require_relative 'theatre'

movies = MovieCollection.new('movies.txt')
puts '*** Sorting ***'
%i(link title year month date country genres duration rating producer actors).each do |field|
  puts movies.sort_by(field).first(5)
  puts
end

%i(month year country producer actors genres).each do |field|
  puts movies.stats(field).inspect
  puts
end

movie = movies.all.first
puts movie.genres.inspect
puts movie.has_genre?('Drama')
puts movie.has_genre?('Comedy')

puts movies.genres.inspect
begin
  movie.has_genre?('Tragedy')
rescue Exception => error
  puts error
end
