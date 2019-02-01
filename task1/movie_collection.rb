require_relative 'movie.rb'

class MovieCollection
  KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze
  
  def initialize(file_path)
    f = File.open(file_path, 'r:UTF-8')
    @films =  f.map {  |film| Movie.new(KEYS.zip(film.strip.split('|')).to_h) }
    f.close
    @genres = @films.flat_map(&:genres).uniq
  end

  def all
    @films
  end

  def movie_sort(movie_field)
   @sort_by(&movie_field)
  end

  def filter(filters)
    filters.reduce(@films) { |result, (key, value)|
    result.select {|films| movie.match?(key, value) } }
  end

  def stats(movie_field)
    films_authors = movie_sort(movie_field).map { |film| film.send(movie_field) }
    films_authors.each_with_object(Hash.new(0)) { |movie_field, hsh| hsh[movie_field] += 1 }.to_h
  end
  
  def genre_exists?(genre)
     @genres.include?(genre)
  end
end
