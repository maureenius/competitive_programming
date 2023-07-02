lottery_count = gets.to_i
lottery_results = gets.chomp.split(' ').map(&:to_i)

win_counts = [0]
(1..lottery_count).each do |index|
  win_counts[index] = win_counts[index-1] + lottery_results[index-1]
end

def answer(sum, start_num, end_num)
  w = sum[end_num] - sum[start_num-1]
  total = end_num - start_num + 1
  l = total - w

  if w - l == 0
    'draw'
  elsif w - l < 0
    'lose'
  else
    'win'
  end
end

q_count = gets.to_i
q_count.times do
  li, ri = gets.chomp.split(' ').map(&:to_i)
  print("#{answer(win_counts, li, ri)}\n")
end
