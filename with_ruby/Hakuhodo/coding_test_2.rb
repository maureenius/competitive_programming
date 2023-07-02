# frozen_string_literal: true

def alphabets
  ('a'..'z')
end

# @param [String] first
# @param [String] second
def is_anagram(first, second)
  return false unless first.length == second.length

  counting_first = {}
  alphabets.each do |alphabet|
    counting_first[alphabet] = 0
  end

  counting_second = {}
  alphabets.each do |alphabet|
    counting_second[alphabet] = 0
  end

  first.each_char do |c|
    counting_first[c] += 1
  end

  second.each_char do |c|
    counting_second[c] += 1
  end

  alphabets.each do |alphabet|
    return false unless counting_first[alphabet] == counting_second[alphabet]
  end

  true
end

# puts is_anagram('abc', 'bca')
#
# puts is_anagram('ab', 'bca')

puts is_anagram('aaaaaabbccc', 'ccbbaaccaaaa')
