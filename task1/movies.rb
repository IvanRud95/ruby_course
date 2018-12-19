KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze

movies = CSV.foreach(FILE_NAME, col_sep: '|', headers: KEYS).map { |movie_arr| build_movie(movie_arr) }

def show_films(sorted)
  sorted.each_with_index do |movie, index|
    puts "#{index + 1}.#{movie[:name]}: (#{movie[:date]}\; #{movie[:genre]}) - #{movie[:duration]}"
  end
end

file_path = ARGV[0] || 'movies.txt'

f = File.open(file_path)
films = f.map {|movie| KEYS.zip(movie.strip.split('|')).to_h}

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
sorted = films.map {|movie| movie[:author]}.sort_by {|name| name.split(' ').last}
puts sorte
