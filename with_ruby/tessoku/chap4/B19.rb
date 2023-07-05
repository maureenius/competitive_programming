is_local = true
is_profiling = false

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
  v_max = 1000 * n
  over_weight = w + 1

  dp_table = [Array.new(v_max+1, over_weight)]
  dp_table[0][0] = 0
  1.upto(n) do |n_index|
    upper_row = dp_table[n_index-1]
    dp_table << (current_row = upper_row.dup)
    current_goods = goods[n_index-1]

    current_row.each_index do |v_index|
      next if current_row[v_index] >= over_weight

      v_index_when_get_goods = v_index+current_goods.value
      weight_when_get_goods = upper_row[v_index] + current_goods.weight
      next if weight_when_get_goods > w

      if (v_index_when_get_goods <= v_max) && (current_row[v_index_when_get_goods] > weight_when_get_goods)
        current_row[v_index_when_get_goods] = weight_when_get_goods
      end
    end
  end

  result = 0
  dp_table[-1].each_index.reverse_each do |v_index|
    if dp_table[-1][v_index] <= w
      result = v_index
      break
    end
  end
  print("#{result}\n")
end

if is_local
  if is_profiling
    n = 100
    w = 1_000_000_000
    goods_arr = Array.new(n) { Array.new(2, 1) }

    profiling { run(n, w, goods_arr) }
  else
    run(4, 7, [[3, 13], [3, 17], [5, 29], [1, 10]])

    run(3, 100, [[55,2],[75,3],[40,2]])

    run(10, 1000000000, [[80000000,99],[11000000,119],[12000000,150],[15000000,174],[16000000,168],[18000000,190],[19000000,187],[25000000,273],[28000000,307],[30000000,319]])
  end
else
  n,w = gets.chomp.split(' ').map(&:to_i)
  goods_arr = []
  n.times do
    goods_arr << gets.chomp.split(' ').map(&:to_i)
  end

  run(n, w, goods_arr)
end
