is_local = true
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [Array<Integer>] a_arr
# @param [String] s
def run(n, a_arr, s)
  m0_count = []
  m1_count = []
  m2_count = []

  x0_count = []
  x1_count = []
  x2_count = []

  j_indexes = []

  s.each_char.with_index do |char, index|
    next unless ['M', 'E', 'X'].include?(char)


  end


end

if is_local
  if is_profiling
    n = 2 * 10**3
    a_arr = Array.new(n, 1)
    s = (0..n-1).inject('') do |memo, element|
      char = case element % 3
             when 0 then 'M'
             when 1 then 'E'
             when 2 then 'X'
             end
      memo.concat(char)
    end

    profiling { run(n, a_arr, s) }
  else
    run(4, [1,1,0,2], 'MEEX')

    run(3, [0,0,0], 'XXX')

    run(15, [1,1,2,0,0,2,0,2,0,0,0,0,0,2,2], 'EXMMXXXEMEXEXMM')
  end
else
  n = gets.to_i
  a_arr = gets.chomp.split(' ').map(&:to_i)
  s = gets.chomp

  run(n, a_arr, s)
end
