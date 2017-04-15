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
        title: Faker::GameOfThrones.character,
        body: Faker::Lorem.paragraph
    )
end

puts "Seed finished"
puts "#{User.count} lists created"
puts "#{Wiki.count} items created"

