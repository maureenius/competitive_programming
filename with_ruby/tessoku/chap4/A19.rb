is_local = true
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Integer] w
# @param [Array<Array<Integer>>] goods_arr
def run(n, w, goods_arr)
  good = Struct.new(:weight, :value)
  goods = goods_arr.map { |item| good.new(item[0], item[1]) }

  dp_table = Array.new(n+1) { Array.new(w+1, nil) }
  dp_table[0][0] = 0
  1.upto(n) do |n_index|
    upper_row = dp_table[n_index-1]
    current_row = dp_table[n_index]
    current_goods = goods[n_index-1]

    upper_row.each_index.select { |i| !upper_row[i].nil? }.each do |cell_index|
      current_row[cell_index] = upper_row[cell_index] if (current_row[cell_index].nil?) || (current_row[cell_index] < upper_row[cell_index])

      cell_index_when_get_goods = cell_index+current_goods.weight
      value_when_get_goods = upper_row[cell_index] + current_goods.value

      if (cell_index_when_get_goods <= w) && (current_row[cell_index_when_get_goods].nil? || current_row[cell_index_when_get_goods] < value_when_get_goods)
        current_row[cell_index_when_get_goods] = value_when_get_goods
      end
    end
  end

  print("#{dp_table[-1].reject { |item| item.nil? }.max}\n")
end

if is_local
  if is_profiling
    n = 100
    w = 100000
    goods_arr = Array.new(n) { Array.new(2, 1) }

    profiling { run(n, w, goods_arr) }
  else
    run(4, 7, [[3, 13], [3, 17], [5, 29], [1, 10]])

    run(4, 100, [[25, 47], [25, 53], [25, 62], [25, 88]])

    run(10, 285, [[29,8000],[43,11000],[47,10000],[51,13000],[52,16000],[66,14000],[72,25000],[79,18000],[82,23000],[86,27000]])

    run(4, 7, [[3, 13], [3, 17], [5, 290], [1, 10]])
  end
else
  n,w = gets.chomp.split(' ').map(&:to_i)
  goods_arr = []
  n.times do
    goods_arr << gets.chomp.split(' ').map(&:to_i)
  end

  run(n, w, goods_arr)
end
