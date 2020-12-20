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

def valid_fields(fields, value)
  fields.select { |_name, values| values.include?(value) }.keys
end

def valid_ticket?(fields, ticket)
  ticket.all? { |value| valid_fields(fields, value).size > 0 }
end

def valid_tickets(fields, tickets)
  tickets.select { |ticket| valid_ticket?(fields, ticket) }
end

def fields(data)
  tickets = data[:tickets]
  fields = data[:fields]
  possible_field_meanings = Array.new(tickets[0].size, data[:fields].keys)

  valid_tickets(fields, tickets).each do |ticket|
    ticket.each_with_index do |value, i|
      possible_field_meanings[i] = possible_field_meanings[i] & valid_fields(fields, value)
    end
  end

  field_order = []

  while field_order.compact.length < fields.length do
    (0...possible_field_meanings.length).each do |i|
      if possible_field_meanings[i].length == 1
        field_order[i] = possible_field_meanings[i].first
      elsif (possible_field_meanings[i] - field_order).length == 1
        field_order[i] = (possible_field_meanings[i] - field_order).first
      end
    end
  end

  field_order
end

def decoded_ticket
  data = dataset
  fields = fields(data)
  fields.zip(data[:ticket]).to_h
end

pp decoded_ticket.select { |k, _v| k.start_with?('departure') }.values.reduce(:*)
