is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Integer] l
# @param [Integer] k
# @param [Array<Integer>] a_arr
def run(n, l, k, a_arr)
  def able?(score, l, k, a_arr)
    cut_count = 0

    before_cut_point = 0
    a_arr.each do |a_elem|
      next if a_elem - before_cut_point < score

      cut_count += 1
      before_cut_point = a_elem
      break if cut_count == k
    end

    (cut_count == k) && (l - before_cut_point) >= score
  end

  result = (0..l).bsearch { |elem| !able?(elem, l, k, a_arr) } || 1

  print("#{result - 1}\n")
end

if is_local
  if is_profiling
  else
    run(3, 34, 1, [8,13,26])

    run(7, 45, 2, [7,11,16,20,28,34,38])

    run(3, 100, 1, [28,54,81])

    run(3, 100, 2, [28,54,81])

    run(20, 1000, 4, [51,69,102,127,233,295,350,388,417,466,469,523,553,587,720,739,801,855,926,954])
  end
else
  n, l = gets.chomp.split(' ').map(&:to_i)
  k = gets.to_i
  a_arr = gets.chomp.split(' ').map(&:to_i)

  run(n, l, k, a_arr)
end
