is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] h
# @param [Integer] w
# @param [Array<String>] maze
def run(h, w, maze)
  dp_table = Array.new(h) { Array.new(w, 0) }
  dp_table[0][0] = 1

  0.upto(h-1) do |i_index|
    0.upto(w-1) do |j_index|
      next if maze[i_index][j_index] == '#'

      if j_index > 0
        if maze[i_index][j_index-1] == '.'
          dp_table[i_index][j_index] += dp_table[i_index][j_index-1]
        end
      end

      if i_index > 0
        if maze[i_index-1][j_index] == '.'
          dp_table[i_index][j_index] += dp_table[i_index-1][j_index]
        end
      end
    end
  end

  print("#{[dp_table[h-1][w-1], 0].max}\n")
end

if is_local
  if is_profiling
    profiling { run }
  else
    run(4, 8, %w[.....#.. ........ ..#...#. #.......])
  end
else
  h, w = gets.chomp.split(' ').map(&:to_i)
  maze = []
  h.times do
    maze << gets.chomp
  end

  run(h, w, maze)
end
