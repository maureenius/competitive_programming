room_num = gets.to_i
rooms = gets.chomp.split(' ').map(&:to_i)

max_room_l = [rooms[0]]
(1..room_num-1).each do |index|
  max_room_l[index] = [max_room_l[index-1], rooms[index]].max
end

max_room_r = Array.new(room_num, 0)
max_room_r[room_num-1] = rooms.last
(0..room_num-2).reverse_each do |index|
  max_room_r[index] = [max_room_r[index+1], rooms[index]].max
end

construction_days = gets.to_i
construction_days.times do
  l, r = gets.chomp.split(' ').map(&:to_i)
  result = [max_room_l[l-2], max_room_r[r]].max
  print("#{result}\n")
end
