is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Array] eq_arr
def run(n, eq_arr)
  answer = 0

  eq_arr.each do |current|
    case current[0]
    when '+' then
      answer += current[1]
    when '-' then
      answer -= current[1]
    when '*' then
      answer *= current[1]
    else
      raise StandardError
    end

    answer += 10000 if answer < 0
    answer %= 10000

    print("#{answer}\n")
  end
end

if is_local
else
  n = gets.to_i
  eq_arr = []
  n.times do
    t, a = gets.chomp.split(' ')

    eq_arr << [t, a.to_i]
  end

  run(n, eq_arr)
end
