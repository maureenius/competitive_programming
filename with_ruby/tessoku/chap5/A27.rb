is_local = false
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] a
# @param [Integer] b
def run(a, b)
  while a > 0 && b > 0
    a, b = b, a if b < a

    b = b % a
  end

  print("#{[a, b].max}\n")
end

if is_local
  if is_profiling
    profiling { run(1_000_000_000, 999_999_999) }
  else
    run(33, 88)

    run(123, 777)
  end
else
  a, b = gets.chomp.split(' ').map(&:to_i)

  run(a, b)
end
