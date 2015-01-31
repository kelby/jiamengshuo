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

Wish.create!(content: "我老爸不断提醒我：“干活一定要找个好师傅，跟他学习，对你很有帮助，一定要找一个师傅。”<br>
              我希望在这个网站里，能找到自己的导师；或者发现欣赏的人，成为他的导师。")