# frozen_string_literal: true


input_line = gets.chomp

result_hash = {}
alphabets.each do |c|
  result_hash[c] = 0
end

stack = []

