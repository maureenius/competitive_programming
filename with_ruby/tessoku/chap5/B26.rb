is_local = false
is_profiling = true

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

# @param [Integer] n
def run(n)
  def prime?(x)
    !(2.upto(Math.sqrt(x)).any? { |target| x % target == 0 })
  end

  mark_sheet = Array.new(n+1, nil)

  2.upto(n) do |target|
    next unless mark_sheet[target].nil?

    mark_sheet[target] = true
    (2*target).step(n, target) do |index|
      mark_sheet[index] = false
    end
  end

  print("#{2.upto(n).select { |index| mark_sheet[index] }.join("\n")}\n")
end

if is_local
  if is_profiling
    profiling { run((10 ** 6).to_i) }
  else
    run(20)
  end
else
  run(gets.to_i)
end
