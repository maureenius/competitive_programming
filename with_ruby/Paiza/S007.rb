# @param [String] input_line
def interpret(input_line)
  results = []

  mag_str = ''
  counting_numeral = false
  input_line.each_char do |c|
    counting_numeral = true if is_numeral?(c)

    if counting_numeral
      if is_numeral?(c)
        mag_str += c
        next
      else
        results << mag_str.to_i
        mag_str = ''
        counting_numeral = false
      end
    end

    results << c
  end

  results
end

def extract_parentheses_content(words)
  stack = []
  words.each do |char|
    if char == '('
      stack.push('')
    elsif char == ')'
      if stack.size > 1
        temp = stack.pop
        stack[-1] += "(" + temp + ")"
      end
    else
      stack[-1] += char if stack.any?
    end
  end
  stack
end

# @param [Array] words
def calculate(words, results, mag_total)
  mag_current = 1

  words.each_index do |word_index|
    if words[word_index].integer?
      mag_current = words[word_index].to_i
      mag_total *= mag_current
    end

    if words[word_index] == '('
      depth = 1
      sentence = words[word_index+1..]
      sentence_last =

      calculate((..words.last))
    end
  end
end

# @return [Range]
def alphabets
  ('a'..'z')
end

# @return [Boolean]
def is_alphabet?(c)
  alphabets.include?(c)
end

# @return [Array]
def brackets
  %w[( )]
end

# @return [Boolean]
def is_numeral?(c)
  ('0'..'9').include?(c)
end

input_line = gets.chomp

result_hash = {}
alphabets.each do |c|
  result_hash[c] = 0
end

words = interpret(input_line)

calculate(parsed, result_hash, 1)

alphabets.each do |c|
  puts("#{c} #{result_hash[c]}")
end
