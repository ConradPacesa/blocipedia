require 'faker'


#create users
10.times do
  User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end

users = User.all

#create wikis
30.times do
  Wiki.create!(
  title: Faker::Food.ingredient,
  body: Faker::Lorem.paragraph(6),
  user: users.sample
  )
end

admin = User.create!(
  name: 'admin',
  email: 'admin@example.com',
  password: 'password',
  role: 'admin'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
