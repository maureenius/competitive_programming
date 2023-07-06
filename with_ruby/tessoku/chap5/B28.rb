is_local = false
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
def run(n)
  denominator = 10**9+7
  a_n_2 = 1
  a_n_1 = 1

  answer = 0
  3.upto(n) do
    answer = a_n_1 + a_n_2
    a_n_2 = a_n_1 % denominator
    a_n_1 = answer % denominator
  end

  print("#{answer % denominator}\n")
end

if is_local
  if is_profiling
    profiling { run(10_000_000) }
  else
    run(6)

    run(8691200)
  end
else
  run(gets.to_i)
end
