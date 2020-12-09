PREAMBLE_LEN = 25

def sums(values)
  values.combination(2).map(&:sum).uniq
end

def invalid_number(values)
  ptr = PREAMBLE_LEN
  loop do
    value = values[ptr]

    return value unless sums(values[(ptr - PREAMBLE_LEN)..(ptr-1)]).include?(value)

    ptr += 1
  end
end

def contiguous_ranges(values, length, target_sum)
  ptr = 0

  while ptr + length < values.length do
    group = values[ptr...(ptr + length)]

    if group.sum == target_sum
      puts "GROUP: #{group}"
      return group.min + group.max
    end

    ptr += 1
  end

  false
end

values = File.read('./day9.txt').split("\n").map(&:to_i)
invalid_number = invalid_number(values)

focus_range = values[0..values.index(invalid_number)]

puts "invalid: #{invalid_number}"
puts contiguous_ranges(focus_range, 4, invalid_number)

for length in 2..(values.length / 2)
  sum = contiguous_ranges(focus_range, length, invalid_number)

  if sum
    puts "SUM: #{sum}"
    exit
  end
end
