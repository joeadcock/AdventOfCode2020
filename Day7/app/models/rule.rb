class Rule < ApplicationRecord
  belongs_to :container
  has_many :container_rules
  has_many :contains, through: :container_rules, source: :container

  def bags_contained
    count = 1
    container_rules.each do |container_rule|
      next if container_rule.count == 0

      # count += container_rule.count
      # puts "count: #{container_rule.count}"
      puts "Finding #{container_rule.container.color}"
      count += (container_rule.count * Rule.find_by(container: container_rule.container).bags_contained)
      puts "count: #{count}"
    end

    count
  end
end
