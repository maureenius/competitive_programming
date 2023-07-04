# @param [Integer] n
# @param [Array<Integer>] as
def run(n, as)
  results = Array.new(n, 0)

  sorted_as = as.map.with_index { |item_a, index| {item_a => index} }
                .sort_by { |item| item.first[0] }

  numbering = 0
  before_number = -1
  sorted_as.each do |item_a|
    numbering += 1 if before_number != item_a.first[0]
    results[item_a.first[1]] = numbering
    before_number = item_a.first[0]
  end

  print("#{results.map(&:to_s).join(' ')}\n")
end

run(5, [46, 80, 11, 77, 46])

run(1, [100])

run(10, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1])

n = gets.to_i
target_as = gets.chomp.split(' ').map(&:to_i)
run(n, target_as)
