is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Integer] s
# @param [Array<Integer>] a_arr
def run(n, s, a_arr)
  dp_table = Array.new(n+1){ Array.new(s+1, false) }

  dp_table[0][0] = true

  1.upto(n) do |n_index|
    before_row = dp_table[n_index-1]
    before_row.each_index.select { |item| before_row[item] }.each do |index|
      dp_table[n_index][index] = true
      next_index = index + a_arr[n_index-1]
      dp_table[n_index][next_index] = true if next_index <= s
    end
  end

  print("#{dp_table[n][s] ? 'Yes' : 'No'}\n")
end

if is_local
  if is_profiling
    n = 60
    s = 10000
    a_arr = Array.new(10000, 2)

    profiling { run(n,s,a_arr) }
  else
    run(3, 7, [2, 2, 3])

    run(3, 7, [2, 3, 3])

    run(4, 11, [3, 1, 4, 5])
  end
else
  arg_1 = gets.chomp.split(' ').map(&:to_i)
  arg_2 = gets.chomp.split(' ').map(&:to_i)

  run(arg_1[0], arg_1[1], arg_2)
end
