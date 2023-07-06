is_local = true
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

def run(n, r)
  def factorial(n, d)
    (1..n).inject { |memo, element| ((memo % d) * (element % d)) % d }
  end

  def power(a, b, d)
    power_2 = a
    answer = 1
    b.to_s(2).reverse.each_char do |binary|
      answer = (answer * power_2) % d if binary == '1'

      power_2 = (power_2 * power_2) % d
    end

    answer % d
  end

  def division(a, b, d)
    (a * power(b, d - 2, d)) % d
  end

  denominator = (10 ** 9 + 7).to_i

  top = factorial(n, denominator) % denominator
  bottom = ((factorial(r, denominator) % denominator) * (factorial(n-r, denominator) % denominator)) % denominator

  result = division(top, bottom, denominator)

  print("#{result}\n")
end

if is_local
  if is_profiling
    r = (10 ** 4).to_i

    profiling { run(100, r) }
  else
    run(4, 2)

    run(97, 998244353)
  end
else
  n, r = gets.chomp.split(' ').map(&:to_i)

  run(n, r)
end
