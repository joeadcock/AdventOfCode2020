require 'pry'

departure, buses = File.read("./day13.txt").split("\n")

departure = departure.to_i
buses = buses.split(',').filter { |b| b != 'x' }.map(&:to_i)

def next_bus_departure(bus, timestamp)
  timestamp + (bus - (timestamp % bus))
end

schedule = buses.map { |bus| [bus, next_bus_departure(bus, departure)] }.to_h

next_departure = schedule.values.min
next_bus = schedule.find { |_bus, timestamp| timestamp == next_departure }[0]

pp (next_departure - departure) * next_bus
