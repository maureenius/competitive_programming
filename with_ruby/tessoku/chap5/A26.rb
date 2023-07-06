is_local = false
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] q
# @param [Array<Integer>] x_arr
def run(q, x_arr)
  def prime?(x)
    2.upto(Math.sqrt(x).to_i) do |target|
      return false if x % target == 0
    end

    true
  end

  x_arr.each do |x|
    print("#{prime?(x) ? 'Yes' : 'No'}\n")
  end
end

if is_local
  if is_profiling
    q = 10000
    x_arr = Array.new(q, 300000)

    profiling { run(q, x_arr) }
  else
    run(4, [17,31,35,49])
  end
else
  q = gets.to_i
  x_arr = []
  q.times do
    x_arr << gets.to_i
  end

  run(q, x_arr)
end
