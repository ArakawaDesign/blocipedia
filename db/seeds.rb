# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
25.times do
    User.create!(
        email: Faker::Internet.unique.email,
        password: Faker::Internet.unique.password
    )
end

50.times do
    Wiki.create!(
        title: Faker::Food.ingredient,
        body: Faker::Food.measurement,
        #user_id: Faker::Number.unique.number(5)
    )
end

user = User.first
user.update_attributes!(
    email: 'arakawa.ryan@gmail.com', # replace this with your personal email
    password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} lists created"
puts "#{Wiki.count} items created"

