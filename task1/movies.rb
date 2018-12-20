require 'csv'
require 'ostruct'

KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze

MONTH_NAMES = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December].freeze

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
films = f.map { |row| OpenStruct.new(KEYS.zip(row).to_h) }


sorted = films.sort_by {|movie| movie[:duration].split(' ')[0].to_i}.last(5)
puts "Films by duration: "
show_films(sorted)

sorted = films.sort_by {|movie| movie[:genre]}
             .select {|movie| movie[:genre].split(',').include?('Comedy')}
             .sort_by {|movie| movie[:date]}.first(10)
puts "Comedies:"
show_films(sorted)


puts "Number of films without USA:"
puts films.count { |m| m[:country] != 'USA' }

puts "Authors:"
sorted = films.map {|movie| movie[:author]}.sort_by {|name| name.split(' ').last}.uniq
puts sorted
