starting_numbers = File.read('./day15.txt').split(',').map(&:to_i)
sequence = {}
starting_numbers.each_with_index { |number, i| sequence[i + 1] = number }

((starting_numbers.count + 1)..30_000_000).each do |i|
  previous = sequence[i - 1]
  index_of_previous = sequence.key(previous)

  if index_of_previous == i - 1
    sequence[i] = 0
  else
    sequence[i] = i - index_of_previous - 1
    sequence[index_of_previous] = nil
  end
end

puts sequence
