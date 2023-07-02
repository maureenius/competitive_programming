num = gets.to_i
success_rates = []
(0..num-1).each do |index|
  inputs = gets.chomp.split(' ').map(&:to_i)
  success_rates[index] = [index+1, inputs[0].quo(inputs[0] + inputs[1])]
end

i = 0
success_rates.sort_by! {|v| [-v[1], i += 1] }

print(success_rates.map { |rate| rate[0]  }.join(' '))
