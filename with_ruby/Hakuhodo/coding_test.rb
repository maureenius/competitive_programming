# frozen_string_literal: true

# @param [Array] array
def remove(array, threshold)
  array.filter { |elem| elem <= threshold }
end

# @param [Array] array
# @param [Integer] total
def two_sum(array, total)
  result = false

  all_array = remove(array, total)

  all_array.each do |first|
    remove(all_array, first).each do |second|
      return true if first + second == total
    end
  end

  result
end

puts two_sum([10, 15, 3, 7], 17)

puts two_sum([1, 2, 3, 4], 10)
