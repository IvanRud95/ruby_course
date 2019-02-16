class Movie

  attr_accessor :collection, :url, :title, :year, :country, :date, :genre, :length, :rating, :director, :actors, :period, :price

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
    case @period
      when :ancient then "#{@title} - old movie (#{@year})"
      when :classic then "#{@title} - classic movie, director: #{@director} (also: #{collection.filter(director: @director)
        .map(&:title).delete_if { |title| title === @title }.first(10).join(', ')})"
      when :modern  then "#{@title} - modern movie, actors: #{actors.join(', ')}"
      when :new     then "#{@title} - new brand movie, released #{Time.now.year - @year} years ago"
    end
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
