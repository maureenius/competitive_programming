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
  def find_smallest_missing_number(arr)
    (0..).find { |i| !arr.include?(i) }
  end

  compressed = []
  m_indexes = []
  e_indexes = []
  x_indexes = []
  s.each_char.with_index do |char, index|
    c = [char, a_arr[index]]

    case char
    when 'M' then
      compressed << c
      m_indexes << compressed.length-1
    when 'E' then
      compressed << c
      e_indexes << compressed.length-1
    when 'X' then
      compressed << c
      x_indexes << compressed.length-1
    else raise StandardError
    end
  end

  results = []
  m_indexes.each do |m_index|
    m_value = compressed[m_index][1]

    e_indexes.each do |e_index|
      next if e_index < m_index

      e_value = compressed[e_index][1]

      x_indexes.each do |x_index|
        next if x_index < e_index

        x_value = compressed[x_index][1]

        results << find_smallest_missing_number([m_value, e_value, x_value])
      end
    end
  end

  print("#{results.sum}\n")
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
