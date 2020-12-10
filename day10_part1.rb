adapters = File.read('./day10.txt').split("\n").map(&:to_i).sort

diffs = Hash.new(0)

diffs[adapters[0]] += 1

(0...(adapters.length - 1)).each do |i|
  diffs[adapters[(i + 1)] - adapters[i]] += 1
end

diffs[3] += 1

puts diffs.values.reduce(:*)
