def unique_questions(group)
  group_answers = Set[]

  group.split("\n").each do |person|
    person.chars.each { |answer| group_answers << answer }
  end

  group_answers.count
end

def all_answered(group)
  group_answers = Hash.new(0)

  forms = group.split("\n")
  forms.each do |form|
    form.chars.each do |answer|
      group_answers[answer] += 1
    end
  end

  group_answers.select { |_k, v| v == forms.size }.count
end

groups = File.read('./day6.txt').split(/\n\n/)

puts(groups.sum { |group| unique_questions(group) })
puts(groups.sum { |group| all_answered(group) })
