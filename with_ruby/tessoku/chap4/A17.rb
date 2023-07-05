require 'ruby-prof'

# @param [Integer] n
# @param [Array<Integer>] as
# @param [Array<Integer>] bs
def run(n, as, bs)
  def dp(n, as, bs)
    results = [0, as[0]]
    2.upto(n-1) do |index|
      short_route_time = results[index-1] + as[index-1]
      long_route_time = results[index-2] + bs[index-2]
      results << (short_route_time > long_route_time ? long_route_time : short_route_time)
    end

    results
  end

  dp = dp(n, as, bs)
  results = [n]
  current_room = n
  while current_room > 1
    if dp[current_room-2] + as[current_room-2] < dp[current_room-3] + bs[current_room-3]
      current_room -= 1
    else
      current_room -= 2
    end
    results << current_room
  end

  print("#{results.size}\n#{results.reverse.join(' ')}\n")
end

n = 100000
as = Array.new(n-1, 1)
bs = Array.new(n-2, 2)

RubyProf.start

run(n, as, bs)

# ... code to profile ...
result = RubyProf.stop

# print a flat profile to text
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT, min_percent: 1)

# run(3, [2, 4], [10])

# run(5, [2,4,1,4], [5,3,3])

# run(gets.to_i, gets.chomp.split(' ').map(&:to_i), gets.chomp.split(' ').map(&:to_i))
