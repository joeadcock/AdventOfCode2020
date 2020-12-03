def trees_by_angle(right, down)
  map = File.read('./day3.txt').split
  x = 0
  y = 0
  trees = 0
  width = map[0].size

  while y < map.size
    trees += 1 if map[y][x] == '#'

    y += down
    x = (x + right) % width
  end

  trees
end

puts trees_by_angle(1, 1) *
     trees_by_angle(3, 1) *
     trees_by_angle(5, 1) *
     trees_by_angle(7, 1) *
     trees_by_angle(1, 2)
