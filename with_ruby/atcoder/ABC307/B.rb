is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Array<String>] s_arr
def run(n, s_arr)
  def palindrome?(s)
    (0..s.length/2).each do |index|
      return false if s[index] != s[s.length-index-1]
    end

    true
  end

  n.times do |x_index|
    n.times do |y_index|
      next if x_index == y_index

      if palindrome?(s_arr[x_index] + s_arr[y_index])
        print("Yes\n")
        return
      end
    end
  end

  print("No\n")
end

if is_local
  if is_profiling
    profiling { run }
  else
    run
  end
else
  n = gets.to_i
  s_arr = []
  n.times do
    s_arr << gets.chomp
  end

  run(n, s_arr)
end
