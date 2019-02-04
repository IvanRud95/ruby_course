class Movie

  attr_accessor :collection, :url, :title, :year, :country, :date, :genre, :length, :rating, :director, :actors

  def initialize(collection, url, title, year, country, date, genre, length, rating, director, actors)
    @collection = collection
    @url        = url
    @title      = title
    @year       = year.to_i
    @country    = country
    @date       = date
    @genre      = genre.split(',')
    @length     = length
    @rating     = rating
    @director   = director
    @actors     = actors.split(',')
  end

  def has_genre?(genre)
    raise "'#{genre}' genre does not exist." unless collection.genre_exists?(genre)
    @genre.include?(genre)
  end

  def to_s
    "#{@name}: (#{@date}; #{@genre}) - #{@duration} - #{@author}"
  end

  def match?(field, filter)
    field_value = self.send(field)
    if field_value.is_a?(Array)
      field_value.any? { |field| filter === field }
    else
      filter === field_value
    end
  end

end
