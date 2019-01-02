require 'csv'
require 'ostruct'
require 'date'

KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze

movies = MovieCollection.new('movies.txt')
%i(link name year country date genre duration rating author actors).each do |field|
  puts movies.sort_by(field).first(5)
  puts
end

