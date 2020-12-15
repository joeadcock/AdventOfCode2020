require 'pry'

departure, buses = File.read('./day13.txt').split("\n")

buses = buses.split(',').map(&:to_i)

# sorted_buses = buses.sort.reverse
sorted_buses = buses

def next_bus_departure(bus, timestamp)
  timestamp + (bus - (timestamp % bus))
end

def synced_timestamps?(other_bus, diff, timestamp)
  (timestamp + diff) % other_bus == 0
end

def next_relative_departure(bus, other_bus, diff, timestamp, other_busses = [])
  x = (timestamp.to_f / bus).ceil

  synced_timestamps = synced_timestamps?(other_bus, diff, timestamp)

  if (synced_timestamps)
    # synced timestamp
    next_timestamp = timestamp + other_bus
  else
    # unsynced timestamp
    x += 1
    while ((x * bus + diff) % other_bus) != 0 do
      print '.'
      x += 1
    end
    next_timestamp = x * bus
  end
end

# this assumes that the bus and other_buses are already "synced"
def next_synced_departure(bus, other_bus, diff, timestamp, synced_buses)
  puts "next_synced_departure(#{bus}, #{other_bus}, #{diff}, #{timestamp}, #{synced_buses}"
  lcd = synced_buses.reduce(:*) || bus
  puts "LCD: #{lcd}"

  next_timestamp = timestamp

  while (next_timestamp + diff) % other_bus != 0 do
    next_timestamp += lcd
  end

  next_timestamp
end

bus = sorted_buses[0]
synced_buses = [bus]
timestamp = 0
sorted_buses.each do |next_bus|
  next if next_bus == bus

  next if next_bus == 0

  diff = buses.index(next_bus) - buses.index(bus)

  timestamp = next_synced_departure(bus, next_bus, diff, timestamp, synced_buses)
  synced_buses << next_bus

  puts timestamp
end
