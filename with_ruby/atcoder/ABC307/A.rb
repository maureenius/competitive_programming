is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Array<Integer>] a_arr
def run(n, a_arr)
  results = []
  n.times do |week|
    results << "#{a_arr[(week*7..week*7+6)].sum}"
  end

  print("#{results.join(' ')}\n")
end

if is_local
  if is_profiling
    profiling { run }
  else
    run()
  end
else
  run(gets.to_i, gets.chomp.split(' ').map(&:to_i))
end
