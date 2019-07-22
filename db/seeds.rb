# frozen_string_literal: true

clients = %w[
  client1
  client2
  client3
]

before_count = User.all.size

clients.each do |client_name|
  existing_client = User.find_by(client_name: client_name)
  if existing_client
    puts "#{client_name} EXISTS"
    next
  end

  User.create(client_name: client_name)
  puts "#{client_name} CREATED"
end

after_count = User.all.size

puts "CREATED #{after_count - before_count} USERS"
