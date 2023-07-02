# frozen_string_literal: true

def cost(start_station, end_station, route_costs)
  if start_station <= end_station
    route_costs[end_station] - route_costs[start_station]
  else
    route_costs[start_station] - route_costs[end_station]
  end
end

def calculate(route_costs, via_points)
  result = 0
  current_position = 1

  via_points.each do |via_point|
    route_index = via_point[0]
    result += cost(current_position, via_point[1], route_costs[route_index])
    current_position = via_point[1]
  end

  result
end

route_num, station_num = gets.chomp.split(' ').map(&:to_i)
route_cost = {}
(1..route_num).each do |route_index|
  input_line = gets.chomp.split(' ').map(&:to_i)
  route_cost[route_index] = [0] + input_line
end
via_station_num = gets.chomp.to_i
via_points = []
via_station_num.times do
  via_points << gets.chomp.split(' ').map(&:to_i)
end

puts calculate(route_cost, via_points)
