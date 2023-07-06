is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] arg_a
# @param [Integer] arg_b
def run(arg_a, arg_b)
  a, b = arg_a, arg_b

  while a > 0 && b > 0
    a, b = b, a if b < a

    b = b % a
  end
  gcd = [a, b].max

  print("#{(arg_a*arg_b/gcd)}\n")
end

if is_local
  if is_profiling
    profiling { run(1_000_000_000, 999_999_999) }
  else
    run(25, 30)

    run(998244353, 998244853)
  end
else
  a, b = gets.chomp.split(' ').map(&:to_i)

  run(a, b)
end
