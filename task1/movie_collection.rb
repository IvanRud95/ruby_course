require_relative 'movie.rb'

class MovieCollection
  KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze
  
  def initialize(file_path)
    f = File.open(file_path, 'r:UTF-8')
    @films =  f.map {  |film| Movie.new(KEYS.zip(film.strip.split('|')).to_h) }
    f.close
  end

  def all
    @films
  end

  def movie_sort(movie_field)
   @sort_by(&movie_field)
  end

  def filter(movie_field, value)
    @films.select { |film| film.send(movie_field).include?(value) }
  end

  def stats(movie_field)
    films_authors = movie_sort(movie_field).map { |film| film.send(movie_field) }
    films_authors.each_with_object(Hash.new(0)) { |movie_field, hsh| hsh[movie_field] += 1 }.to_h
  end
  
  def genre_exists?(genre)
     @all_genres.include?(genre)
  end
