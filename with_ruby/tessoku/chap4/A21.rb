is_local = true
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

class Coordinate
  attr_reader :i, :j

  def initialize(arg_i, arg_j)
    @i = arg_i
    @j = arg_j
  end

  def left
    Coordinate.new(i, j-1)
  end

  def under
    Coordinate.new(i+1, j)
  end
end

# @param [Integer] n
# @param [Array<Array<Integer>>] block_arr
def run(n, block_arr)
  dp_table = Array.new(n+1) { Array.new(n+1, 0) }

  stacks = [Coordinate.new(1, n)]
  until stacks.empty?
    current = stacks.pop
    next if current.i == current.j

    def score(next_coor, block)
      block[0] > next_coor.i && block[0] < next_coor.j ? block[1] : 0
    end

    if current.j > 0
      left = current.left
      stacks.push(left)
      dp_table[left.i][left.j] = dp_table[current.i][current.j] + score(left, block_arr[left.i-1])
    end

    if current.i < n
      under = current.under
      stacks.push(under)
      dp_table[under.i][under.j] = dp_table[current.i][current.j] + score(under, block_arr[under.i-1])
    end
  end

  results = []
  1.upto(n) do |index|
    results << dp_table[index][index]
  end

  print("#{results.max}\n")
end

if is_local
  if is_profiling
    n = 2000
    block_arr = Array.new(n) { Array.new(2, 100) }

    profiling { run(n, block_arr) }
  else
    run(4, [[4,20],[3,30],[2,40],[1,10]])

    run(8, [[8,100],[7,100],[6,100],[5,100],[4,100],[3,100],[2,100],[1,100]])
  end
else
  n = gets.to_i
  block_arr = []
  n.times do
    block_arr << gets.chomp.split(' ').map(&:to_i)
  end

  run(n, block_arr)
end
