is_local = true
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [String] s
# @param [String] t
def run(s, t)
  dp_table = Array.new(s.length+1) { Array.new(t.length+1, 0) }
  dp_table[0].each_index do |index|
    next if index == 0

    dp_table[0][index] = dp_table[0][index-1] + 1
  end

  1.upto(s.length) do |s_index|
    before_s_index = s_index-1
    before_row = dp_table[before_s_index]
    current_row = dp_table[s_index]

    current_row.each_index do |t_index|
      upper = before_row[t_index] + 1
      if t_index == 0
        current_row[t_index] = upper
        next
      end

      before_t_index = t_index-1
      left = current_row[before_t_index] + 1
      upper_left_cell_value = before_row[before_t_index]
      upper_left = s[before_s_index] == t[before_t_index] ? upper_left_cell_value : upper_left_cell_value + 1

      current_row[t_index] = [upper, left, upper_left].min
    end
  end

  print("#{dp_table[s.length][t.length]}\n")
end

if is_local
  if is_profiling
    require 'securerandom'
    n = 2000

    profiling { run(SecureRandom.alphanumeric(n), SecureRandom.alphanumeric(n)) }
  else
    run('tokyo', 'kyoto')

    run('competitive', 'programming')

    run('abcdef', 'bdf')
  end
else
  run(gets.chomp, gets.chomp)
end
