def execute_program(instructions)
  pos = 0
  acc = 0
  visited = {}

  while true
    if pos >= instructions.count
      puts "Successfully terminated"
      return true
    end

    if visited[pos]
      puts "Inifinite loop at #{pos}"
      return false
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
end


instructions = File.read('./day8.txt').split("\n")
# execute_program(instructions)

instructions.each_with_index.select { |instruction, i| %w[nop jmp].include? instruction[0..2] }.each do |instruction, i|
  debugged_instructions = instructions.dup

  operation, argument = debugged_instructions[i].split
  operation = operation == 'nop' ? 'jmp' : 'nop'
  debugged_instructions[i] = "#{operation} #{argument}"
  puts '------------------------------------'
  puts "Swapping #{instructions[i]} with #{debugged_instructions[i]}"
  puts '------------------------------------'

  if execute_program(debugged_instructions)
    puts "success!!"
    exit
  end
end
