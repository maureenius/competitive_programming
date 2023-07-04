n, k = gets.chomp.split(' ').map(&:to_i)
as = gets.chomp.split(' ').map(&:to_i)

first_group, second_group = as.each_slice((n.to_f*0.5).ceil).to_a
second_group = [] if second_group.nil?

def total_box(box_a, box_b)
  result_box = []
  box_a.each do |item_a|
    box_b.each do |item_b|
      result_box << item_a + item_b
    end
  end

  result_box
end

def each_subset(arr)
  result = []
  1.upto(arr.size) { |n| result += arr.combination(n).to_a }
  result
end

def each_total(arr)
  each_subset(arr).map { |subset| subset.sum }
end

first_total_group = each_total([0] + first_group)
second_total_group = each_total([0] + second_group).sort!

result = first_total_group.map do |item_first|
  goal = k - item_first
  second_total_group.bsearch { |x| x >= goal } == goal
end.any?

print(result ? 'Yes' : 'No')
