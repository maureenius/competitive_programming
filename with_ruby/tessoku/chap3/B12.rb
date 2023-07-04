n = gets.to_i

result_max = 10 ** 5

def check(x, goal)
  x ** 3 + x < goal
end

def binary_search(head, bottom, goal)
  while bottom - head > 0.001
    center = (head + bottom) * 0.5
    check(center, goal) ? head = center : bottom = center
  end

  head
end

print("#{binary_search(0, result_max, n)}")
