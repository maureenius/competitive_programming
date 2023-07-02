inputs = gets.chomp.split(' ').map(&:to_i)

pre_input = 0
result = 'Yes'
inputs.each do |i|
  if pre_input > i
    result = 'No'
    break
  end

  if i < 100 || i > 675
    result = 'No'
    break
  end

  if i % 25 > 0
    result = 'No'
    break
  end

  pre_input = i
end

print(result)
