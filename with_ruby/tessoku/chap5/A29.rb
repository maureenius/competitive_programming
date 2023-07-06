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
  denominator = (10**9+7).to_i

  power_2 = a
  answer = 1
  b.to_s(2).reverse.each_char do |binary|
    answer = (answer * power_2) % denominator if binary == '1'

    power_2 = (power_2 * power_2) % denominator
  end

  print("#{answer % denominator}\n")
end

if is_local
  if is_profiling
    profiling { run(1_000_000_000, (10**18).to_i) }
  else
    run(5, 23)

    run(97, 998244353)
  end
else
  a, b = gets.chomp.split(' ').map(&:to_i)

  run(a, b)
end
