def bisect(min, max, direction)
  mid = (min + max) / 2
  %w[F L].include?(direction) ? [min, mid] : [mid + 1, max]
end

def row(row_code)
  min = 0
  max = 127

  row_code.chars[0..-2].each do |direction|
    min, max = bisect(min, max, direction)
  end

  row_code[-1] == 'F' ? min : max
end

def col(col_code)
  min = 0
  max = 7

  col_code.chars[0..-2].each do |direction|
    min, max = bisect(min, max, direction)
  end

  col_code[-1] == 'L' ? min : max
end

def seat_id(code)
  row(code[0..6]) * 8 + col(code[7..9])
end

seat_ids = File.read('./day5.txt').split().map { |code| seat_id(code) }
(seat_ids.min..seat_ids.max).to_a - seat_ids
