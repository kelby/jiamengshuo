# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do
  User.create!(username: Faker::Name.name, email: Faker::Internet.email, password: 'password')
end

%w(hots recommend tags badges divider course wish_list).each do |page|
  Page.create!(name: page)
end
