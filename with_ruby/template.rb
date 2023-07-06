is_local = true
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

def run

end

if is_local
  if is_profiling
    profiling { run }
  else
    run
  end
else
  run
end
