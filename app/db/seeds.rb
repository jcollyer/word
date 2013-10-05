# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "seed data goes here"

Biblebook.create([
  {
    title: "genesis",
    order: 1
  },
  {
    title: "leviticus",
    order: 2
  }
])

puts "Complete! yous"
