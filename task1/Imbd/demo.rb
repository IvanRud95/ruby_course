require_relative 'movie_collection'
require_relative 'movie'


 movies = MovieCollection.new

 puts movies.all

 puts movies.all.first.actors
 puts movies.all.first(5).map(&:genre)

 puts movies.sort_by(:genre)
 puts movies.sort_by(:year)

 begin
   puts movies.all.first.has_genre?('Comedy')
   puts movies.all.first.has_genre?('Drama')
   puts movies.all.first.has_genre?('Ololol')
 rescue Exception => error
  puts error
 end
 
 puts movies.filter(genre: 'Comedy', year: 2010)
 puts movies.filter(year: 2014..2015)
 puts movies.filter(year: 2010)
 puts movies.filter(director: /Coppola/)
 puts movies.filter(actors: /Hanks/)

 puts movies.stats(:year).map { |m| m.flatten.join(' -> ') }
 puts movies.stats(:genre).map { |m| m.flatten.join(' -> ') }
 puts movies.stats(:actors).map { |m| m.flatten.join(' -> ') }

