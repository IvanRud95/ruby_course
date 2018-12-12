ax=[]
File.open('movies.txt').each do |line|
  ax<<line.split(/\|(?=[\w])/)
end
ax.select{|x| x if x[1].include? 'Max'}.each do |y|
  puts y[1]
  puts '*' * ((y[7].to_f - 8)*10).to_i
end
