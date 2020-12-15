class FerryProgram
  def initialize
    @mask = ''
    @mem = Hash.new(0)
  end

  def update_mask(value)
    @mask = value
  end

  def masked_value(mask, value)
    masked_value = ''
    value.to_s(2).rjust(36, '0').chars.each_with_index do |bit, i|
      masked_value[i] =
        if mask[i] == '0'
          bit
        elsif mask[i] == '1'
          '1'
        else
          'X'
        end
    end
    masked_value
  end

  def masked_addresses(mask, address)
    masked_address = masked_value(mask, address)

    addresses = ['']
    masked_address.chars.each do |bit|
      if %w[0 1].include?(bit)
        addresses.each { |a| a << bit }
      else
        addresses0 = addresses.map(&:clone)
        addresses1 = addresses.map(&:clone)

        addresses0.each { |a| a << '0' }
        addresses1.each { |a| a << '1' }
        addresses = addresses0 + addresses1
      end
    end

    addresses.map { |a| a.to_i(2) }.sort
  end

  def write_value(address, value)
    masked_addresses(@mask, address).each { |a| @mem[a] = value }
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
      print '.'
      perform(command)
    end

    puts @mem.values.sum
  end
end

FerryProgram.new.run
