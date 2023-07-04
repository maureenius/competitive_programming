n, k = gets.chomp.split(' ').map(&:to_i)
target_arr = gets.chomp.split(' ').map(&:to_i)

result_max = 10 ** 9

def check(arr, x, k)
  arr.inject(0) { |result, item| result + x / item } >= k
end

def binary_search(arr, head, bottom, goal)
  while head < bottom
    center = (head + bottom) / 2
    check(arr, center, goal) ? bottom = center : head = center+1
  end

  head
end

print("#{binary_search(target_arr, 0, result_max, k)}\n")
