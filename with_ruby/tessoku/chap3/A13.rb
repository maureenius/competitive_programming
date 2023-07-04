n, k = gets.chomp.split(' ').map(&:to_i)
target_arr = gets.chomp.split(' ').map(&:to_i)

result = 0
right = 0
(0..n-2).each do |left|
  while (right < n-1) && (target_arr[right + 1] - target_arr[left] <= k)
    right += 1
  end

  result += right - left
end

print("#{result}")
