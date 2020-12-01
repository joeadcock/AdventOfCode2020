entries = File.read('./day1.txt').split.map(&:to_i)

def find_multiple_of_sum(entries, sum)
  entries.each do |entry1|
    entries.each do |entry2|
      next if entry1 == entry2
      next if entry1 + entry2 != sum

      return entry1 * entry2
    end
  end
end

puts find_multiple_of_sum(entries, 2020)
