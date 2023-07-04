n, x = gets.chomp.split(' ').map(&:to_i)

def search(arr, head, bottom, target)
  center = (head + bottom) / 2

  if arr[center] == target
    center
  elsif arr[center] > target
    search(arr, head, center-1, target)
  else
    search(arr, center+1, bottom, target)
  end
end

print(search(gets.chomp.split(' ').map(&:to_i), 0, n-1, x)+1)
