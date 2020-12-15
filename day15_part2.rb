require 'pry'
starting_numbers = File.read('./day15.txt').split(',').map(&:to_i)
sequence = {}
starting_numbers.each_with_index { |number, i| sequence[number] = i + 1 }

previous = sequence.key(starting_numbers.length)
sequence[previous] = nil

((starting_numbers.count + 1)..30_000_000).each do |i|
  # puts i
# ((starting_numbers.count + 1)..2020).each do |i|
  if sequence[previous].nil?
    sequence[previous] = i - 1
    previous = 0
  else
    diff = i - 1 - sequence[previous]
    sequence[previous] = i - 1
    previous = diff
  end

  # puts sequence
end

puts previous
