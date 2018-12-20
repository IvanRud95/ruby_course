KEYS = [:link, :name, :year, :country, :date, :genre, :duration, :rating, :author, :actors].freeze

MONTH_NAMES = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December].freeze

movies = CSV.foreach(FILE_NAME, col_sep: '|', headers: KEYS).map { |movie_arr| build_movie(movie_arr) }

def show_films(sorted)
  sorted.each_with_index do |movie, index|
    puts "#{index + 1}.#{movie[:name]}: (#{movie[:date]}\; #{movie[:genre]}) - #{movie[:duration]}"
  end
end

file_path = ARGV[0] || 'movies.txt'

def build_movie(data)
  data = data.to_h

  OpenStruct.new(
    data.merge({
      year: data[:year].to_i,
      duration: data[:duration].to_i,
      rating: data[:rating].to_f,
      genres: data[:genres].split(','),
      starring: data[:starring].split(','),
      month: get_month(data[:date]),
      date: parse_date(data[:date])
    })
  )
end

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
