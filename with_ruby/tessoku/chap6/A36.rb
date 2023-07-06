is_local = false
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Integer] k
def run(n, k)
  shortest = (n-1)*2
  extra = k - shortest
  if extra < 0
    print("No\n")
    return
  end

  print("#{extra % 2 == 0 ? 'Yes' : 'No'}\n")
end

if is_local
  if is_profiling
    profiling { run(1000000000, 1000000000) }
  else
    run(5, 10)

    run(5, 9)

    run(2, 1)

    run(2, 4)
  end
else
  n, k = gets.chomp.split(' ').map(&:to_i)
  run(n, k)
end
