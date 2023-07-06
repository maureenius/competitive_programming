is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] h
# @param [Integer] w
# @param [Array<String>] s_arr
def run(h, w, s_arr)
  def next_char(current_char)
    case current_char
    when 's' then 'n'
    when 'n' then 'u'
    when 'u' then 'k'
    when 'k' then 'e'
    when 'e' then 's'
    else raise StandardError
    end
  end

  stacks = []
  checked = Array.new(h) { Array.new(w, false) }
  if s_arr[0][0] == 's'
    stacks << [0, 0]
    checked[0][0] = true
  end

  result = false
  until stacks.empty?
    current = stacks.pop
    if current[0] == h - 1 && current[1] == w - 1
      result = true
      break
    end
    checked[current[0]][current[1]] = true

    nears = []
    nears << [current[0]-1, current[1]] if current[0] > 0
    nears << [current[0]+1, current[1]] if current[0] < h-1
    nears << [current[0], current[1]-1] if current[1] > 0
    nears << [current[0], current[1]+1] if current[1] < w-1

    correct_char = next_char(s_arr[current[0]][current[1]])
    nears.select { |element| s_arr[element[0]][element[1]] == correct_char && !checked[element[0]][element[1]] }.each do |element|
      stacks.push(element)
    end
  end

  print("#{result ? 'Yes' : 'No'}\n")
end

if is_local
  if is_profiling
  else
    run(2, 3, ['sns', 'euk'])

    run(2, 3, ['ab', 'cd'])

    run(5, 7, ['skunsek', 'nukesnu', 'ukeseku', 'nsnnesn', 'uekukku'])
  end
else
  h, w = gets.chomp.split(' ').map(&:to_i)
  s_arr = []
  h.times do
    s_arr << gets.chomp
  end

  run(h, w, s_arr)
end
