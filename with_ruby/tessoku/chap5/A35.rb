is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

def run(n, a_arr)
  board = [a_arr]

  1.upto(n-1) do |row_index|
    upper_row = board[row_index-1]
    board << (current_row = [])

    cell_num = n - row_index
    is_first_turn = cell_num % 2 == 1
      0.upto(cell_num-1) do |column_index|
      candidates = [upper_row[column_index], upper_row[column_index+1]]
      current_row << (is_first_turn ? candidates.max : candidates.min)
    end
  end

  print("#{board[-1][0]}\n")
end

if is_local
  if is_profiling
    profiling { run(2000, 100000) }
  else
    run(4, [20, 10, 30, 40])

    run(2, [1, 1])

    run(5, [20, 10, 50, 40, 30])
  end
else
  run(gets.to_i, gets.chomp.split(' ').map(&:to_i))
end
