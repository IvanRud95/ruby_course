class Movie

  GenreNotFoundError = Class.new(RuntimeError)

  attr_reader :link,
              :name,
              :year,
              :country,
              :date,
              :genre,
              :duration,
              :rating,
              :author,
              :actors,
              :collection

  def initialize(collection = nil, movie = {})
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
    @collection = collection
  end

  def has_genre?(genre)
    raise "'#{genre}' genre does not exist." unless collection.genre_exists?(genre)
    @genre.include?(genre)
  end

  def match?(field, filter)
    field_value = self.send(field)
    if field_value.is_a?(Array)
      field_value.any? {|field| filter === field}
    else
      filter === field_value
    end
  end

  def to_s
    "#{@name}: (#{@date}\; #{@genre}) - #{@duration} - #{@author}"
  end


  def inspect
    "#{title} | #{country} | #{year} | #{producer} | #{genre} | #{actors}"
  end
end
