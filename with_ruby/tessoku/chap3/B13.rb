n, k = gets.chomp.split(' ').map(&:to_i)
target_arr = gets.chomp.split(' ').map(&:to_i)
sum_arr = target_arr.inject([0]) { |result, item| result << result[-1] + item }

right = 1
result = 0
(1..n-1).each do |index|
  sum = sum_arr[right] - sum_arr[index-1]
  while (right < n) && (sum <= k)
    right += 1
    break if right > n

    sum += target_arr[right-1]
  end

  result += right - index
end

result += 1 if target_arr[-1] <= k
print(result)
