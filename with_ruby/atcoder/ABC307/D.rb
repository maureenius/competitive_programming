is_local = true
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
# @param [String] s
def run(n, s)
  def extract_elements_outside_intervals(arr, intervals)
    # インターバルを開始インデックスでソート
    intervals.sort_by! { |a| a[0] }

    # 重複するインターバルをマージ
    merged_intervals = [intervals[0]]
    intervals[1..].each do |current|
      last = merged_intervals[-1]
      # 重複するインターバルがある場合、終了インデックスを更新
      if current[0] <= last[1]
        last[1] = [last[1], current[1]].max
      else
        merged_intervals << current
      end
    end

    # マージされたインターバルを利用して配列から要素を抽出
    result = []
    j = 0
    arr.each_char.with_index do |value, i|
      while j < merged_intervals.size && i > merged_intervals[j][1]
        j += 1
      end
      if j == merged_intervals.size || i < merged_intervals[j][0]
        result << value
      end
    end
    result
  end

  start_stacks = []
  delete_ranges = []
  (0..n-1).each do |index|
    current_char = s[index]

    if current_char == '('
      start_stacks.push(index)
    end

    if current_char == ')' && !start_stacks.empty?
      start_index = start_stacks.pop
      delete_ranges << [start_index, index]
    end
  end

  if delete_ranges.empty?
    print(s)
  else
    print_chars = extract_elements_outside_intervals(s, delete_ranges)

    print("#{print_chars.join}")
  end

  print("\n")
end

if is_local
  if is_profiling
    n = 2 * 10 ** 5
    chars = []
    n.times do
      chars << case rand(3)
      when 0 then '('
      when 1 then 'a'
      when 2 then ')'
      end
    end

    profiling { run(n, chars.join) }
  else
    run(9, 'a(b)c(d)e')

    run(8, 'a(b(d))c')

    run(5, 'a(b)(')

    run(2, '()')

    run(6, ')))(((')
  end
else
  run(gets.to_i, gets.chomp)
end
