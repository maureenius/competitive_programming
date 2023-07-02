height, width = gets.chomp.split(' ').map(&:to_i)
sum_map = []
height.times do
  cells = gets.chomp.split(' ').map(&:to_i)
  sum_row = []
  cells.each_with_index do |cell, index|
    if index == 0
      sum_row[index] = cell
    else
      sum_row[index] = cell + sum_row[index-1]
    end
  end

  sum_map << sum_row
end

(1..height-1).each do |h_index|
  width.times do |w_index|
    sum_map[h_index][w_index] += sum_map[h_index-1][w_index]
  end
end

q_count = gets.to_i
q_count.times do
  a, b, c, d = gets.chomp.split(' ').map(&:to_i).map { |x| x-1 }

  result = 0
  if a == 0 && b == 0
    result = sum_map[c][d]
  elsif b == 0
    result = sum_map[c][d] - sum_map[a-1][d]
  elsif a == 0
    result = sum_map[c][d] - sum_map[c][b-1]
  else
    result = sum_map[c][d] - sum_map[a-1][d] - sum_map[c][b-1] + sum_map[a-1][b-1]
  end

  print("#{result}\n")
end
