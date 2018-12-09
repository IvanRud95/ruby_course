
movies = {
    'Matrix'  => 'Matrix is a good movie'
    'Titanic' => 'Titanic is - a bad movie' }

movie_name = ARGV[0]

  if movies.key? movie_name
    puts movies[movie_name]
  else
    puts "Haven't seen '#{movie_name}' yet"
  end
