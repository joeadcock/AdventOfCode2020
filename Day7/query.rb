# shiny bag 
container = Container.find_by(color: 'shiny gold')
inner_container_ids = [container.id]

count = 0
until count == inner_container_ids.count
  puts "."
  count = inner_container_ids.count
  inner_container_ids.push(Rule.joins(:contains).where(container_rules: { container: inner_container_ids }).pluck('rules.container_id'))
  inner_container_ids = inner_container_ids.flatten.uniq
  puts inner_container_ids.count
end

puts "Bag combinations: inner_container_ids.count - 1"


# part 2

container = Container.find_by(color: 'shiny gold')
rule = Rule.find_by container: container
