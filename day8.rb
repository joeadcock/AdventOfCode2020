instructions = File.read('./day8.txt').split("\n")

pos = 0
acc = 0
visited = {}

while true
  if visited[pos]
    puts "Inifinite loop at #{pos}"
    exit
  end

  visited[pos] = true

  instruction = instructions[pos]
  operation, argument = instruction.split
  puts "Acc: #{acc}, Pos: #{pos}, op: #{operation}, arg: #{argument}"

  if(operation == 'nop')
    pos += 1
    next
  elsif(operation == 'acc')
    acc += argument.to_i
    pos += 1
    next
  elsif(operation == 'jmp')
    pos += argument.to_i
    next
  else
    puts "invalid operation!: #{operation}"
  end
end
