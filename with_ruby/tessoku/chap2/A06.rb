def answer(sum, start_date, end_date)
  sum[end_date] - sum[start_date-1]
end

day_count, q_count = gets.chomp.split(' ').map(&:to_i)
guest_counts = gets.chomp.split(' ').map(&:to_i)

guest_sums = [0]
(1..day_count).each do |index|
  guest_sums[index] = guest_sums[index-1] + guest_counts[index-1]
end

q_count.times do
  d_start, d_end = gets.chomp.split(' ').map(&:to_i)
  print("#{answer(guest_sums, d_start, d_end)}\n")
end
