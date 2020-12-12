def total_progress(commands, direction)
  directions = %w[N E S W]
  waypoint = {
    'N' => 1,
    'E' => 10,
    'S' => 0,
    'W' => 0
  }

  progress = Hash.new(0)

  commands.each do |cmd|
    puts "Progress: #{progress}"
    puts "Waypoint: #{waypoint}"
    puts "cmd: #{cmd}"

    dir = cmd[0]
    amount = cmd[1..-1].to_i

    case dir
    when 'F'
      directions.each do |d|
        progress[d] += waypoint[d] * amount
      end
    when 'S'
      waypoint['S'] += amount
    when 'N'
      waypoint['N'] += amount
    when 'E'
      waypoint['E'] += amount
    when 'W'
      waypoint['W'] += amount
    when 'R'
      waypoint = waypoint.keys.zip(waypoint.values.rotate(amount / -90)).to_h
    when 'L'
      waypoint = waypoint.keys.zip(waypoint.values.rotate(amount / 90)).to_h
    end

    waypoint = normalize_directions(waypoint)
    progress = normalize_directions(progress)
  end

  progress
end

def normalize_directions(directions)
  if directions['E'] > directions['W']
    directions['E'] -= directions['W']
    directions['W'] = 0
  elsif directions['W'] > directions['E']
    directions['W'] -= directions['E']
    directions['E'] = 0
  elsif directions['W'] == directions['E']
    directions['W'] = directions['E'] = 0
  end

  if directions['S'] > directions['N']
    directions['S'] -= directions['N']
    directions['N'] = 0
  elsif directions['N'] > directions['S']
    directions['N'] -= directions['S']
    directions['S'] = 0
  elsif directions['N'] == directions['S']
    directions['N'] = directions['S'] = 0
  end

  directions
end

commands = File.read('./day12.txt').split("\n")
puts total_progress(commands, 'E').values.sum
