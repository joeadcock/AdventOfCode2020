def find_multiple_of_sum(count, sum)
  entries = File.read('./day1.txt').split.map(&:to_i)
  entries.combination(count).find { |combo| combo.sum == sum }.reduce(&:*)
end

puts find_multiple_of_sum(3, 2020)
