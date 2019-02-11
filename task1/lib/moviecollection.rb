
require 'csv'


class MovieCollection
  
  include Enumerable
  
    class GenreNotExist < StandardError; end
    class ValueNotExist < StandardError; end
  
  KEYS = [:url, :title, :year, :country, :date, :genre, :length, :rating, :director, :actors]

  def initialize(file_name = ARGV.first)
    default_name = 'movies.txt'
    file_name ||= default_name

    unless File.exist?(file_name)
      puts "File doesn't exist."
      exit
    end

    @movies = CSV.read(file_name, write_headers: true, headers: KEYS, col_sep: '|').map(&:to_h)
                  .map { |m| Movie.new(self, m[:url], m[:title], m[:year], m[:country], m[:date], m[:genre], m[:length], m[:rating], m[:director], m[:actors]) }
    @all_genres = @movies.map(&:genre)
  end

  def all
    @movies
  end

  def sort_by(value)
    @movies.sort_by(&value)
  end

  def stats(value)
    @movies.map(&value).flatten
        .group_by { |value| value }.map { |k, v| { k => v.count } }
  end

  def to_s
    "#{@movies}"
  end

  def genre_exists?(genre)
    @all_genres.include?(genre)
  end

  def filter(filters)
    filters.reduce(@movies) { |result, (key, value)|
      result.select {|movies| movies.match?(key, value) } }
  end
  end
