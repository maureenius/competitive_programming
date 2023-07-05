# @param [Integer] n
# @param [Array<Integer>] h_arr
def run(n, h_arr)
  def cost(a, b)
    (a-b).abs
  end

  results = [0, cost(h_arr[0], h_arr[1])]
  2.upto(n-1).each do |index|
    short_cost = results[index-1] + cost(h_arr[index-1], h_arr[index])
    long_cost = results[index-2] + cost(h_arr[index-2], h_arr[index])
    results << [short_cost, long_cost].min
  end

  print("#{results[-1]}\n")
end

# run(4, [10, 30, 40, 20])
#
# run(2, [10, 10])
#
# run(6, [30,10,60,10,60,50])

run(gets.to_i, gets.chomp.split(' ').map(&:to_i))
