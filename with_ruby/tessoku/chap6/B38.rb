is_local = true
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [String] s
def run(n, s)
  def correct(array)
    (0..array.length-1).reverse_each do |index|
      array[index] += 1
      break if index > 0 && array[index-1] < array[index]
    end
  end

  results = [1]
  (0..n-2).each do |index|
    current_h = (s[index] == 'A') ? results[index] + 1 : [results[index] - 1, 1].min
    if current_h < 1
      correct(results)
      current_h += 1
    end

    results << current_h
  end

  print("#{results.sum}\n")
end

if is_local
  if is_profiling
    n = 3000

    profiling { run(n, Array.new(n, 'B').join('')) }
  else
    run(7, 'AABBBA')

    run(7, 'BBBBBB')

    run(1, '')

    run(5, 'BABA')

    run(8, 'AABABBB')
  end
else
  run(gets.to_i, gets.chomp)
end
