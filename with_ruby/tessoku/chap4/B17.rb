is_local = false
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

def run(arg_n, arg_h_arr)
  def cost(a, b)
    (a-b).abs
  end

  def dp(n, h_arr)
    results = [0, cost(h_arr[0], h_arr[1])]
    2.upto(n-1).each do |index|
      short_cost = results[index-1] + cost(h_arr[index-1], h_arr[index])
      long_cost = results[index-2] + cost(h_arr[index-2], h_arr[index])
      results << [short_cost, long_cost].min
    end

    results
  end

  n = arg_n.to_i
  h_arr = arg_h_arr.chomp.split(' ').map(&:to_i)

  dp_result = dp(n, h_arr)

  results = [n]
  current_floor = n
  while current_floor > 1
    if current_floor == 2
      results << 1
      break
    end

    if dp_result[current_floor-2] + cost(h_arr[current_floor-2], h_arr[current_floor-1]) < dp_result[current_floor-3] + cost(h_arr[current_floor-3], h_arr[current_floor-1])
      current_floor -= 1
    else
      current_floor -= 2
    end
    results << current_floor
  end

  print("#{results.size}\n#{results.reverse.join(' ')}\n")
end

if is_local
  if is_profiling
    n = 100000
    h_arr = Array.new(n, 10).map(&:to_s).join(' ')

    profiling { run(n.to_s, h_arr) }
  else
    run('4', '10 30 40 20')

    run('4', '10 100 30 20')

    run('2', '10 10')

    run('6', '30 10 60 10 60 50')
  end
else
  run(gets, gets)
end
