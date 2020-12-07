module RuleImporter
  def self.import
    Rule.transaction do
      policies.each do |policy|
        container, contents = policy.gsub('bags', '').gsub('bag', '').gsub('.', '').split('contain')
        container.strip!
        contents = contents.split(',').map(&:strip)

        rule = Rule.create container: Container.find_or_create_by(color: container)
        puts "Container: '#{container}'"

        contents.each do |content|
          count = content.to_i
          container = Container.find_or_create_by(color: content[content.index(' ') + 1..])
          ContainerRule.create rule: rule, container: container, count: count
          puts "Content: #{count} #{container.color}"
        end
      end
    end
  end

  def self.policies
    File.read('./db/day7.txt').split("\n")
  end
end
