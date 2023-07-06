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
# @param [String] s
def run(n, k, s)
  extra = k - s.each_char.count { |char|  char == '1' }
  print("#{extra % 2 == 0 ? 'Yes' : 'No'}\n")
end

if is_local
  if is_profiling
    n = 3*10**5
    s = Array.new(n, '1').join('')

    profiling { run(n, n, s) }
  else
    run(7, 3, '1010111')

    run(7, 3, '1010110')

    run(2, 0, '11')
  end
else
  n, k = gets.chomp.split(' ').map(&:to_i)
  s = gets.chomp

  run(n, k, s)
end
