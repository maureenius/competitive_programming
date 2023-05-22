# frozen_string_literal: true

n, x, y = gets.chomp.split(" ").map(&:to_i)

(1..n).each do |i|
  if i % x == 0 and i % y == 0
    puts("AB")
  elsif i % x == 0
    puts("A")
  elsif i % y == 0
    puts("B")
  else
    puts("N")
  end
end
