X_MAX = 10
Y_MAX = 10

point_count = gets.to_i
points = Array.new(X_MAX) { Array.new(Y_MAX, 0) }
point_count.times do
  x, y = gets.chomp.split(' ').map(&:to_i)
  points[x][y] += 1
end

point_sum = []
points.each do |row|
  sum_row = [row[0]]
  (1..row.length-1).each do |cell|
    sum_row[cell] = sum_row[cell-1] + row[cell]
  end
  point_sum << sum_row
end

(1..X_MAX-1).each do |h_index|
  Y_MAX.times do |w_index|
    point_sum[h_index][w_index] += point_sum[h_index-1][w_index]
  end
end

q_count = gets.to_i
q_count.times do
  a, b, c, d = gets.chomp.split(' ').map(&:to_i).map { |x| x-1 }

  result = 0
  if a == 0 && b == 0
    result = point_sum[c][d]
  elsif b == 0
    result = point_sum[c][d] - point_sum[a-1][d]
  elsif a == 0
    result = point_sum[c][d] - point_sum[c][b-1]
  else
    result = point_sum[c][d] - point_sum[a-1][d] - point_sum[c][b-1] + point_sum[a-1][b-1]
  end

  print("#{result}\n")
end
