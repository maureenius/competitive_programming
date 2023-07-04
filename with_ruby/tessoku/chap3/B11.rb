def search(arr, head, bottom, target)
  return arr[head] >= target ? head : head+1 if head == bottom

  center = (head + bottom) / 2

  if arr[center] >= target
    search(arr, head, center, target)
  else
    search(arr, center+1, bottom, target)
  end
end

n = gets.to_i
target_arr = gets.chomp.split(' ').map(&:to_i).sort!
q = gets.to_i
q.times do
  x = gets.to_i

  if x > target_arr[n-1]
    print("#{n}\n")
    next
  end

  print("#{search(target_arr, 0, n-1, x)}\n")
end
