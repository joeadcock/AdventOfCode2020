require 'digest'

ferry = File.read('./day11.txt').split("\n").map(&:chars)
LENGTH = ferry.length
WIDTH = ferry[0].length

def dir_score(ferry, row, seat, row_delta, seat_delta)
  if (row + row_delta >= LENGTH) || (row + row_delta < 0) ||
    (seat + seat_delta >= WIDTH) || (seat + seat_delta < 0)
    return 0
  end

  val = ferry[row + row_delta][seat + seat_delta]
  return 0 if val == 'L'
  return 1 if val == '#'

  dir_score(ferry, row + row_delta, seat + seat_delta, row_delta, seat_delta)
end

def score(ferry, row, seat)
  score = 0

  score += dir_score(ferry, row, seat, -1, 0)
  score += dir_score(ferry, row, seat, -1, 1)
  score += dir_score(ferry, row, seat, 0, 1)
  score += dir_score(ferry, row, seat, 1, 1)
  score += dir_score(ferry, row, seat, 1, 0)
  score += dir_score(ferry, row, seat, 1, -1)
  score += dir_score(ferry, row, seat, 0, -1)
  score += dir_score(ferry, row, seat, -1, -1)

  score
end

def occupied?(ferry, row, seat)
  score = score(ferry, row, seat)

  if ferry[row][seat] == 'L'
    score == 0 ? '#' : 'L'
  elsif ferry[row][seat] == '#'
    score >= 5 ? 'L' : '#'
  else
    '.'
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
