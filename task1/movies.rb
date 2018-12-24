require 'csv'
require 'ostruct'
require 'date'

KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze

MONTH = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December].freeze

def show_films(sorted)
  sorted.each_with_index do |movie, index|
    puts "#{index + 1}.#{movie[:name]}: (#{movie[:date]}\; #{movie[:genre]}) - #{movie[:duration]}"
  end
end

file_path = ARGV[0] || 'movies.txt'

unless File.exist?(file_path)
  puts "file #{file_path} dont exist"
  exit 1
end

f = CSV.open(file_path, col_sep: '|', encoding: 'UTF-8')
films = f.map {|row| OpenStruct.new(KEYS.zip(row).to_h)}

puts "_______"
puts "Films by month : "
sorted = films.select {|film| film.date.size == 10}.map {|film| Date.strptime(film.date).mon}
films_by_month = sorted.each_with_object(Hash.new(0)) {|month, hsh| hsh[month] += 1}.sort.to_h
films_by_month.each {|month, movies| puts "#{Date::MONTHNAMES[month]} - #{films_by_month[month]}"}
puts "_______"

sorted = films.sort_by(&:month).last(5)
show_films(sorted)
puts "_______"

sorted = films.sort_by{ |movie| -movie[:duration] }.take(5)
puts "Films by duration: "
show_films(sorted)
puts "_______"

sorted = films.sort_by(&:genre)
             .select{ |movie| movie[:genre].split(',').include?('Comedy') }
             .sort_by(&:date).first(10)
puts "Comedies:"
show_films(sorted)
puts "_______"

puts "Number of films without USA:"
puts films.count{ |m| m[:country] != 'USA' }
puts "_______"

puts "Authors:"
sorted = films.map(&:author).sort_by {|name| name.split(' ').last}.uniq
puts sorted
