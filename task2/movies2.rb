movies = {
    'Matrix'  => 'Matrix is a good movie'
    'Titanic' => 'Titanic is - a bad movie' }

movie_name = ARGV[0]

ax = []

  if movies.key? movie_name
    puts movies[movie_name]
  else
    puts "Haven't seen '#{movie_name}' yet"
  end


File.open('movies.txt').each do |line|
  puts line.split(/\|(?=[\w])/)
end

ax.select{|x| x if x[1].include? 'Max'}.each do |y|
 puts y[1]
 puts '*' * ((y[7].to_f - 8)*10).to_i
end
