class Movie
  attr_accessor :link,
              :name,
              :year,
              :country,
              :date,
              :genre,
              :duration,
              :rating,
              :author,
              :actors
  def initialize(movie = {})
    @link = movie[:link]
    @name = movie[:name]
    @year = movie[:year]
    @country = movie[:country]
    @date = movie[:date]
    @genre = movie[:genre]
    @duration = movie[:duration]
    @rating = movie[:rating]
    @author = movie[:author]
    @actors = movie[:actors]
  end

  def has_genre?(genre)
    @genre.include?(genre) ? "yes it's #{genre}" : "no it's not #{genre}"
  end

  def to_s
    "#{@name}: (#{@date}\; #{@genre}) - #{@duration} - #{@author}"
  end
end
