def valid_password_record?(record)
  range, char, password = record.split(/[ :]+/)
  min, max = range.split('-').map(&:to_i)
  password.count(char).between? min, max
end

File.read('./day2.txt').split("\n").count { |e| valid_password_record?(e) }

def valid_toboggan_password_record?(record)
  positions, char, password = record.split(/[ :]+/)
  first, second = positions.split('-').map(&:to_i)
  (password[first - 1] == char) ^ (password[second - 1] == char)
end

File.read('./day2.txt').split("\n").count { |e| valid_toboggan_password_record?(e) }
