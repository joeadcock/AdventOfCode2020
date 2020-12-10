adapters = File.read('./day10.txt').split("\n").map(&:to_i).sort

chains = Hash.new(0)
chains[0] = 1

(0...adapters.size).each do |index|
  current = adapters[index]

  if adapters.include?(current + 1)
    chains[current] += (chains[current - 1])
    chains[current] += (chains[current - 2])
    chains[current] += (chains[current - 3])
  elsif adapters.include?(current + 2)
    chains[current] += (chains[current - 1])
    chains[current] += (chains[current - 2])
    chains[current] += (chains[current - 3])
    chains.delete(current - 2)
  else
    chains[current] += chains[current - 1]
    chains[current] += chains[current - 2]
    chains[current] += chains[current - 3]
    chains.delete(current - 1)
    chains.delete(current - 2)
  end
  chains.delete(current - 3)

  puts chains
end

puts chains.max
