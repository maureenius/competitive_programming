sushi_count, color_count = gets.chomp.split(' ').map(&:to_i)
sushi_colors = gets.chomp.split(' ').map(&:to_s)
color_names = gets.chomp.split(' ').map(&:to_s)
prices = gets.chomp.split(' ').map(&:to_i)

price_table = {
  'default' => prices[0]
}
color_names.each_with_index do |name, index|
  price_table[name] = prices[index+1]
end

result = 0
sushi_colors.each do |color|
  if price_table.key?(color)
    result += price_table[color]
  else
    result += price_table['default']
  end
end

print(result)
