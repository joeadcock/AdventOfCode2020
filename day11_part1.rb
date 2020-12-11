require 'digest'

ferry = File.read('./day11.txt').split("\n").map(&:chars)
LENGTH = ferry.length
WIDTH = ferry[0].length

def occupied?(ferry, row, seat)
  score = 0

  ((row - 1)..(row + 1)).each do |r|
    next if [-1, LENGTH].include?(r)

    ((seat - 1)..(seat + 1)).each do |c|
      next if [-1, WIDTH].include?(c)

      next if r == row && c == seat

      score += 1 if ferry[r][c] == '#'
    end
  end

  if ferry[row][seat] == 'L'
    return score == 0 ? '#' : 'L'
  elsif ferry[row][seat] == '#'
    return score >= 4 ? 'L' : '#'
  else
    return '.'
  end
end

def iteration(ferry)
  new_ferry = []

  (0...LENGTH).each do |row|
    (0..WIDTH).each do |seat|
      new_ferry[row] ||= []
      new_ferry[row][seat] = occupied?(ferry, row, seat)
    end
  end

  new_ferry
end

def stable_seating(ferry)
  md5 = ''
  loop do
    ferry = iteration(ferry)

    next_md5 = Digest::MD5.hexdigest(ferry.flatten.join)

    return ferry if md5 == next_md5

    md5 = next_md5
  end
end

puts stable_seating(ferry).flatten.join.chars.count { |c| c == '#' }
