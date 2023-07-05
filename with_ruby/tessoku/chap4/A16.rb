# @param [Integer] n
# @param [Array<Integer>] as
# @param [Array<Integer>] bs
def run(n, as, bs)
  results = [0, as[0]]
  2.upto(n-1) do |index|
    short_route_time = results[index-1] + as[index-1]
    long_route_time = results[index-2] + bs[index-2]
    results << (short_route_time > long_route_time ? long_route_time : short_route_time)
  end

  print("#{results[-1]}\n")
end

run(5, [2,4,1,3], [5,3,7])

run(3, [2, 4], [10])

run(5, [2,4,1,3], [5,3,3])

run(gets.to_i, gets.chomp.split(' ').map(&:to_i), gets.chomp.split(' ').map(&:to_i))
