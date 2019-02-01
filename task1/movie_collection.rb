require 'csv'
require 'date'
require_relative 'movie.rb'

class MovieCollection
  KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze

  def initialize(file_path)
    f = File.open(file_path, 'r:UTF-8')
    @films =  f.map {  |film| Movie.new(KEYS.zip(film.strip.split('|')).to_h) }
    @genres = @films.flat_map(&:genre).uniq
  end

  def each(&block)
    @films.each(&block)
  end

  def all
    @films
  end

  def movie_sort(movie_field)
    @sort_by(movie_field)
  end


  def filter(filters)
    filters.reduce(@films) { |result, (key, value)|
      result.select {|films| films.match?(key, value) } }
  end

  def stats(movie_field)
    films_authors = movie_sort(movie_field).map { |film| film.send(movie_field) }
    films_authors.each_with_object(Hash.new(0)) { |movie_field, hsh| hsh[movie_field] += 1 }.to_h
  end

  def print_stats(movie_field)
    stats(movie_field).sort.each do |field_name, count|
      puts "#{field_name}: #{count}"
    end
  end

  def genre_exists?(genre)
    @genre.include?(genre)
  end

  end
