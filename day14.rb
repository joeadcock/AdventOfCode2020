class FerryProgram
  def initialize()
    @mask = ''
    @mem = Hash.new(0)
  end

  def update_mask(value)
    puts "update_mask(#{value})"
    @mask = value
  end

  def write_value(address, value)
    puts "write_value(#{@mem}, #{address}, #{value})"

    masked_value = ''
    value.to_s(2).rjust(36, '0').chars.each_with_index do |bit, i|
      masked_value[i] = @mask[i] == 'X' ? bit : @mask[i]
    end
    @mem[address] = masked_value.to_i(2)
  end

  def perform(command)
    cmd, value = command.split(' = ')

    if cmd == 'mask'
      update_mask(value)
    else
      address = cmd[4..-2].to_i
      value = value.to_i
      write_value(address, value)
    end
  end

  def run
    commands = File.read('./day14.txt').split("\n")
    commands.each do |command|
      puts "CMD: #{command}"
      perform(command)

      puts "MEM: #{@mem}"
      puts "MASK: #{@mask}"
    end

    puts @mem.values.sum
  end
end

FerryProgram.new.run
