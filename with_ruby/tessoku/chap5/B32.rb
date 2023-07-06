is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Array<Integer>] remove_ways
def run(n, remove_ways)
  # @return [Boolean]
  def win?(left_stone, results, remove_ways)
    remove_ways.any? { |way| left_stone >= way && !results[left_stone-way] }
  end

  results = [false]
  1.upto(n) do |stone_num|
    results << win?(stone_num, results, remove_ways)
  end

  print("#{results[-1] ? 'First' : 'Second'}\n")
end

if is_local
  if is_profiling
    n = 100000

    profiling { run(n, 1, 2) }
  else
    run(8, [2, 3])

    run(6, [2, 3])

    run(20, [6, 1, 3])
  end
else
  n, _ = gets.chomp.split(' ').map(&:to_i)
  ways = gets.chomp.split(' ').map(&:to_i)
  run(n, ways)
end
