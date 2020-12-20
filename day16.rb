require 'pry'

def dataset
  data = File.read('./day16.txt').split("\n")

  fields_read = false
  ticket_read = false

  fields = {}
  ticket = ''
  tickets = []

  data.each do |line|
    if line.empty?
      if !fields_read
        fields_read = true
      elsif !ticket_read
        ticket_read = true
      end

      next
    end

    if !fields_read
      name, details = line.split(':')
      ranges = details.split('or').map(&:strip)
      fields[name] = ranges.map { |range| eval(range.sub('-', '..')).to_a }.flatten
    else
      next if line.start_with?(/[a-z]/)

      if !ticket_read
        ticket = line.split(',').map(&:to_i)
      else
        tickets << line.split(',').map(&:to_i)
      end
    end
  end

  { fields: fields, ticket: ticket, tickets: tickets }
end

pp dataset.inspect

def invalid_ticket_fields(fields, ticket)
  valid_values = fields.values.flatten
  ticket - valid_values
end

pp dataset[:tickets].map { |ticket| invalid_ticket_fields(dataset[:fields], ticket) }.flatten.compact.sum
