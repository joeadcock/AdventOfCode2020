REQUIRED_FILEDS = %w[byr iyr eyr hgt hcl ecl pid]

def valid_eye_color?(color)
  %w[amb blu brn gry grn hzl oth].include? color
end

def valid_hair_color?(color)
  color.match?(/^#[0-9a-f]{6}$/)
end

def valid_height?(height)
  return true if height.end_with?('cm') && height.to_i.between?(150, 193)

  return true if height.end_with?('in') && height.to_i.between?(59, 76)

  false
end

def valid_pid?(pid)
  pid.match?(/^[0-9]{9}$/)
end

def valid_year?(year)
  year.match?(/^\d{4}$/)
end

def year_in_range(year, min, max)
  return false unless valid_year?(year)

  year.to_i.between?(min, max)
end

def valid_passport?(passport)
  puts "checking PASSPORT: #{passport}"
  REQUIRED_FILEDS - passport.keys == [] &&
    year_in_range(passport['byr'],1920, 2002) &&
    year_in_range(passport['iyr'],2010, 2020) &&
    year_in_range(passport['eyr'],2020, 2030) &&
    valid_height?(passport['hgt']) &&
    valid_eye_color?(passport['ecl']) &&
    valid_hair_color?(passport['hcl']) &&
    valid_pid?(passport['pid'])
end

passports = File.read('./day4.txt').split(/\n\n/)
passports.count do |passport_data|
  passport = passport_data.split(/[\n ]/).map { |pair| pair.split(':') }.to_h
  valid_passport? passport
end
