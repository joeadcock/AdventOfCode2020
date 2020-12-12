def total_progress(commands, direction)
  directions = %w[N E S W]
  progress = Hash.new(0)

  commands.each do |cmd|
    dir = cmd[0]
    amount = cmd[1..-1].to_i

    case dir
    when 'F'
      progress[direction] += amount
    when 'S'
      progress['S'] += amount
    when 'N'
      progress['N'] += amount
    when 'E'
      progress['E'] += amount
    when 'W'
      progress['W'] += amount
    when 'R'
      puts 'Right'
      direction = directions[(directions.index(direction) + (amount / 90)) % 4]
    when 'L'
      puts 'Left'
      direction = directions[(directions.index(direction) + (-amount / 90)) % 4]
    end

    puts progress
  end

  if progress['E'] > progress['W']
    progress['E'] -= progress['W']
    progress['W'] = 0
  elsif progress['W'] < progress['E']
    progress['W'] -= progress['E']
    progress['E'] = 0
  elsif progress['W'] == progress['E']
    progress['W'] = progress['E'] = 0
  end

  if progress['S'] > progress['N']
    progress['S'] -= progress['N']
    progress['N'] = 0
  elsif progress['N'] < progress['S']
    progress['N'] -= progress['S']
    progress['S'] = 0
  elsif progress['N'] == progress['S']
    progress['N'] = progress['S'] = 0
  end

  progress
end

commands = File.read('./day12.txt').split("\n")
puts total_progress(commands, 'E').values.sum
