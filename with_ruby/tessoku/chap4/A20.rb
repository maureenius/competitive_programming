is_local = false
is_profiling = false

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

  dp_table.each_with_index do |row, i_index|
    next if i_index == 0

    row.each_index do |j_index|
      upper_cell = dp_table[i_index-1][j_index]
      left_cell = j_index > 0 ? dp_table[i_index][j_index-1] : 0
      upper_left_cell = j_index > 0 && s[i_index-1] == t[j_index-1] ? dp_table[i_index-1][j_index-1] + 1 : 0

      row[j_index] = [upper_cell, left_cell, upper_left_cell].max
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
    run('mynavi', 'monday')

    run('tokyo', 'kyoto')

    run('test', 't')
  end
else
  run(gets.chomp, gets.chomp)
end
