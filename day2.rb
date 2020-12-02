def valid_password_record?(record)
  range, char, password = record.split(/[ :]+/)
  min, max = range.split('-').map(&:to_i)
  password.count(char).between? min, max
end

File.read('./day2.txt').split("\n").count { |e| valid_password_record?(e) }
