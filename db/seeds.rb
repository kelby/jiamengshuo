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

10.times do
  Wish.create!(content: Faker::Lorem.paragraph, user_id: User.ids.sample)
  Wish.create!(content: Faker::Lorem.paragraph(2), user_id: User.ids.sample, updated_at: Faker::Time.between(100.days.ago, Time.now))
end

Wish.create!(content: "我老爸不断提醒我：“干活一定要找个好师傅，跟他学习，对你很有帮助，一定要找一个师傅。”<br>
              我希望在这个网站里，能找到自己的导师；或者发现欣赏的人，成为他的导师。", user_id: User.first.id)

['个人发展', '职场', '兴趣爱好', '生活', '设计师', '语言', 'IT技术', '投资理财', '演讲', '其它'].each do |name|
  Catalog.create!(name: name)
end

['创业', '管理', '沟通技巧'].each do |name|
  catalog = Catalog.create!(name: name)
  catalog.parent = Catalog.find_by(name: "职场")
  catalog.save
end

['写小说', '拍微电影', '开咖啡馆'].each do |name|
  Catalog.create!(name: name, parent: Catalog.find_by(name: "兴趣爱好"))
end

['购物', '美食', '理财', '健康', '运动'].each do |name|
  Catalog.create!(name: name, parent: Catalog.find_by(name: "生活"))
end

['艺术', '创意'].each do |name|
  Catalog.create!(name: name, parent: Catalog.find_by(name: "设计师"))
end

['英语', '课程', '书箱'].each do |name|
  Catalog.create!(name: name, parent: Catalog.find_by(name: "语言"))
end

['操作系统', 'ios', 'android', 'web开发'].each do |name|
  Catalog.create!(name: name, parent: Catalog.find_by(name: "IT技术"))
end

['产品', '需求分析', 'axure'].each do |name|
  Catalog.create!(name: name, parent: Catalog.find_by(name: "IT技术"))
end

50.times do
  Section.create!(heading: Faker::Name.name, body: Faker::Lorem.sentence)
  Section.create!(heading: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
  Section.create!(heading: Faker::Name.name, body: Faker::Lorem.paragraph(2))
end

user = User.create!(username: 'Caleb Winters', password: 'password', email: "Caleb_Winters@gmail.com")
topic = Topic.create!(title: Faker::Name.name, user: user, body: Faker::Lorem.paragraph)

comment = Comment.create!(user: user, content: "
          <p>Nice start, Becky. I really like some of the elements you have going so far. The header and footer tie in nicely and the ribbon on tiles works well. The font is great also and looks readable. Here are a few areas you can keep iterating on:</p>

          <p>Simplify your color palette.</p>", topic: topic)

user = User.create!(username: 'Kyle Schmidt Post Author', password: 'password', email: "Kyle_Schmidt@gmail.com")

Reply.create!(content: "Wow, guys. Lots of great feedback.

First, @Milkmusket, I agree. I've struggled with that section and might take advice for @albanesetr and focus on a single feature rather than the whole screenshot.

@Hans, I usually try to go for drop shadows pumped with a little color, may not be the case here but thanks for the comment. And for the header noise, and noise overall in the site, I need to try reducing it all around before we go live.

@albanesetr, thanks for all the good feedback. The pricing plans are definitely still WIP, the yellow $150 should have a 'Most Popular' header, you're right. Other mockups had it, not sure why I haven't put it up yet.

I'll try reducing the header, the active state was just conceptual at this point. For the one shown, I was considering a fixed header and wanted the user to see where they were at when scrolling. So the thick yellow bar would slide when you scroll.

Again, thanks everyone. I really enjoy the feedback on Forrst. Much more in depth than over at Dribbble. :P",
  comment: comment, user: user)

user_ids = User.ids
200.times do
  Apply.create!(user_id: user_ids.sample, mentor_id: user_ids.sample, info: Faker::Lorem.paragraph)
end
