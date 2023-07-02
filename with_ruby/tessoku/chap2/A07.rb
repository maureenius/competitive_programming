total_date = gets.to_i
guest_num = gets.to_i

guest_diffs = Array.new(total_date, 0)
guest_num.times do
  li, ri = gets.chomp.split(' ').map(&:to_i)
  guest_diffs[li-1] += 1
  guest_diffs[ri] -= 1 unless ri >= total_date
end

guest_current = 0
guest_diffs.each do |diff|
  guest_current += diff
  print("#{guest_current}\n")
end
