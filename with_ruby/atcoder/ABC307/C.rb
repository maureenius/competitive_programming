is_local = false
is_profiling = false

def profiling(&block)
  require 'ruby-prof'

  RubyProf.start

  yield

  RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT, min_percent: 1)
end

class Sheet
  attr_reader :height, :width, :pattern

  def initialize(h, w, pattern)
    @height = h
    @width = w
    @pattern = pattern
  end

  def black?(h, w)
    return false if h >= @height || w >= @width

    @pattern[h][w] == '#'
  end

  def black_coordinates
    results = []

    @height.times do |h_index|
      @width.times do |w_index|
        results << [h_index, w_index] if @pattern[h_index][w_index] == '#'
      end
    end

    results
  end

  # @param [Sheet] other
  def overlap(other, corner_h, corner_w)
    new_pattern = []
    (@height + corner_h).times do |h_index|
      row = []
      (@width + corner_w).times do |w_index|
        cell = (black?(h_index, w_index) ? '#' : '.')

        if h_index >= corner_h && w_index >= corner_w
          cell = '#' if other.black?(h_index-corner_h, w_index-corner_w)
        end

        row << cell
      end
      row = row.join
      new_pattern << row
    end

    Sheet.new(@height+corner_h, @width+corner_w, new_pattern)
  end

  def truncate_h
    r = [0, @height-1]
    @height.times do |h_index|
      break if @pattern[h_index].each_char.any? { |char| char == '#' }

      r[0] += 1
    end
    @height.times do |h_index|
      break if @pattern[@height - h_index-1].each_char.any? { |char| char == '#' }

      r[1] -= 1
    end

    @pattern = @pattern[r[0]..r[1]]
  end

  def truncate_w
    r = [0, @width-1]

    @width.times do |w_index|
      break if (0..@height-1).map { |h_index| @pattern[h_index][w_index] }.any? { |char| char == '#' }

      r[0] += 1
    end

    @width.times do |w_index|
      w_coor = @width-w_index-1
      break if (0..@height-1).map { |h_index| @pattern[h_index][w_coor] }.any? { |char| char == '#' }

      r[1] -= 1
    end

    @pattern = @pattern.map { |row| row[r[0]..r[1]] }
  end

  def truncate
    truncate_h
    truncate_w
  end
end


# @param [Sheet] a_sheet
# @param [Sheet] b_sheet
# @param [Sheet] expect_sheet
def run(a_sheet, b_sheet, expect_sheet)
  a_sheet, b_sheet, expect_sheet = a_sheet.truncate, b_sheet.truncate, expect_sheet.truncate



  # a_sheet.height.times do |h_index|
  #   a_sheet.width.times do |w_index|
  #     tmp = a_sheet.overlap(b_sheet, h_index, w_index)
  #     t = 1
  #   end
  # end
end

if is_local
  if is_profiling
    profiling { run }
  else
    run
  end
else
  def input_sheet
    h, w = gets.chomp.split(' ').map(&:to_i)
    pattern = []
    h.times do
      pattern << gets.chomp
    end

    Sheet.new(h, w, pattern)
  end

  run(input_sheet, input_sheet, input_sheet)
end
