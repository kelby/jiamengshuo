# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rails.configuration.i18n.default_locale = :en
Rails.configuration.i18n.available_locales = ["zh-CN", :en]

I18n.locale = :en

50.times do
  User.create!(username: Faker::Name.name, email: Faker::Internet.email, password: 'password', faker: true)
end

%w(hots recommend tags badges divider course wish_list).each do |page|
  Page.create!(name: page)
end

10.times do
  Wish.create(content: Faker::Lorem.paragraph, user_id: User.ids.sample)
  Wish.create(content: Faker::Lorem.paragraph(2), user_id: User.ids.sample, updated_at: Faker::Time.between(100.days.ago, Time.now))
end

Wish.create!(content: "我老爸不断提醒我：“干活一定要找个好师傅，跟他学习，对你很有帮助，一定要找一个师傅。”<br>
              我希望在这个网站里，能找到自己的导师；或者发现欣赏的人，成为他的导师。", user_id: User.first.id)

=begin
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

Catalog.update_all(info: "Cupcake ipsum dolor sit. Amet I love liquorice jujubes pudding croissant I love pudding. Apple pie macaroon toffee jujubes pie tart.")
=end

Catalog.destroy_all

[['母婴用品', "母婴用品是指为孕产期女性与0-3岁婴儿这两类特殊相关联群体提供的专业健康产品。"],
['化妆品', "化妆品是指以涂抹、喷洒或者其他类似方法，散布于人体表面的任何部位，如皮肤、毛发、指趾甲、唇齿等，以达到清洁、保养、美容、修饰和改变外观，或者修正人体气味，保持良好状态为目的的化学工业品或精细化工产品。"],
['商品', "会计学中商品的定义是商品流通企业外购或委托加工完成，验收入库用于销售的各种商品。商品的基本属性是价值和使用价值。价值是商品的本质属性，使用价值是商品的自然属性。"],
['鞋包', "以皮、布、木、草、塑料丝等为材料制作的穿在脚上、走路时着地的东西；生活用包(休闲包、时装包、宴会晚装包、筒包、迪包、腰包、沙滩包、化妆包、银包)、公事和职业用包(女士包、男士包、公文包)、运动和旅行用包、专用包(学生包、电脑包、相机包、手机包、钥匙包)、创意包等。"],
['手机数码', "手机分为智能手机（Smart phone）和非智能手机（Feature phone），一般智能手机的性能比非智能手机要好，但是非智能手机比智能手机性能稳定；数码（digital）系统，又称为数字系统，是使用离散（即不连续的）的0或1来进行信息的输入，处理，传输、存贮等处理的系统。"],
['服饰', "包括服装、鞋、帽、袜子、手套、围巾、领带、提包、阳伞、发饰等。古人，则是用来遮羞，而今人对于新事物的认识不断进步，服饰的材质，样式也多种多样。"],
['酒类', "人们经常消费的一种饮品。在逢年过节、亲朋聚会时，饮酒助兴更是不可或缺。"],
['儿童玩具', "专供儿童游戏使用的物品。玩具是儿童把想象、思维等心理过程转向行为的支柱。儿童玩具能发展运动能力，训练知觉，激发想象，唤起好奇心，为儿童身心发展提供了物质条件。"],
['美妆护肤', "化妆，能表现出人物独有自然美；能改善人物原有的”形“”色“”质“，增添美感和魅力；能作为一种艺术形式，呈现一场视觉盛宴，表达一种感受。"],
['保健用品', "系指供人们生活中使用，表明具有调节人体机能和促进健康等特定功能的用品。"],
['食品饮料', "各种供人食用或者饮用的成品和原料以及按照传统既是食品又是药品的物品，但是不包括以治疗为目的的物品。由不同的配方和制造工艺生产出来，供人或牲畜直接饮用的液体食品。"],
['其他', "其余，不分人与物；其余的人；其余的男子"]].each do |list|
  Catalog.create!(name: list.first, info: list.last)
end

icons = %w(check marker cloud thumbnails laptop usb music lightbulb asterisk puzzle ticket shield crown trophy clipboard  clipboard-pencil)

Catalog.find_each do |catalog|
  catalog.icon = icons.sample
  catalog.icon_from = 'fi'
  catalog.save
end

50.times do
  Section.create!(user_id: User.ids.sample, heading: Faker::Name.name, body: Faker::Lorem.sentence)
  Section.create!(user_id: User.ids.sample, heading: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
  Section.create!(user_id: User.ids.sample, heading: Faker::Name.name, body: Faker::Lorem.paragraph(2))
end

user = User.all.sample # User.create!(username: 'Caleb Winters', password: 'password', email: "Caleb_Winters@gmail.com", faker: true)
100.times do
  topic = Topic.create!(title: Faker::Name.title, user: User.all.sample, body: Faker::Lorem.paragraph,
                        category: Topic.categories.keys.sample,
                        mode: Topic.modes.keys.sample,
                        invoice: Topic.invoices.keys.sample,
                        freight_source: Topic.freight_sources.keys.sample,
                        catalog: Catalog.all.sample,
                        deadline: Faker::Time.between(12.months.ago, Time.now))
end

# Topic.order('id desc').limit(100).destroy_all

topic = Topic.all.sample
comment = Comment.create!(user: user, content: "
          <p>Nice start, Becky. I really like some of the elements you have going so far. The header and footer tie in nicely and the ribbon on tiles works well. The font is great also and looks readable. Here are a few areas you can keep iterating on:</p>

          <p>Simplify your color palette.</p>", commentable: topic)

user = User.create(username: 'Kyle Schmidt Post Author', password: 'password', email: "Kyle_Schmidt@gmail.com", faker: true)

50.times do
  Comment.create!(content: "Wow, guys. Lots of great feedback.

First, @Milkmusket, I agree. I've struggled with that section and might take advice for @albanesetr and focus on a single feature rather than the whole screenshot.

@Hans, I usually try to go for drop shadows pumped with a little color, may not be the case here but thanks for the comment. And for the header noise, and noise overall in the site, I need to try reducing it all around before we go live.

@albanesetr, thanks for all the good feedback. The pricing plans are definitely still WIP, the yellow $150 should have a 'Most Popular' header, you're right. Other mockups had it, not sure why I haven't put it up yet.

I'll try reducing the header, the active state was just conceptual at this point. For the one shown, I was considering a fixed header and wanted the user to see where they were at when scrolling. So the thick yellow bar would slide when you scroll.

Again, thanks everyone. I really enjoy the feedback on Forrst. Much more in depth than over at Dribbble. :P",
  commentable_id: Topic.ids.sample, user_id: User.ids.sample)
end

50.times do
  Comment.create!(content: "## 其它

包含了：Readonly Attributes 和 Translation 等。

### Readonly Attributes

提供方法：

```
attr_readonly

readonly_attributes
```

`attr_readonly` 和其它 attr_x 类似，只不过这里设置的是某属性为只读。注意，这里不是校验，所以保存出错的话，不会放到 record 对象的 errors 里。
",
  commentable_id: Topic.ids.sample, user_id: User.ids.sample)
end

100.times do
  Reply.create!(content: "Wow, guys. Lots of great feedback.

First, @Milkmusket, I agree. I've struggled with that section and might take advice for @albanesetr and focus on a single feature rather than the whole screenshot.

I'll try reducing the header, the active state was just conceptual at this point. For the one shown, I was considering a fixed header and wanted the user to see where they were at when scrolling. So the thick yellow bar would slide when you scroll.

Again, thanks everyone. I really enjoy the feedback on Forrst. Much more in depth than over at Dribbble. :P",
  comment_id: Comment.ids.sample, user_id: User.ids.sample)
end

100.times do
  Reply.create!(content:
"### 跳过回调

主要有 3 种方式：

#### update_columns

类似 update_columns，直接使用不会触发回调的方法进行操作。

#### skip_callback

跳过某个回调。

#### x_without_callbacks

以 object.send(:x_without_callbacks) 跳过某个系列的回调。",
  comment_id: Comment.ids.sample, user_id: User.ids.sample)
end

user_ids = User.ids
200.times do
  Apply.create(user_id: user_ids.sample, mentor_id: user_ids.sample, info: Faker::Lorem.paragraph.first(20))
end

User.where(id: user_ids.sample(10)).update_all info: "求指导，求教育，万一我一不小心绽放了。。。 。。。 无限感激"
User.where(id: user_ids.sample(10)).update_all info: "互联网爱好者，努力充电，寻找机遇。"
User.where(id: user_ids.sample(10)).update_all info: "Dreams will keep me young."
User.where(id: user_ids.sample(10)).update_all info: "求指导，求教育，万一我一不小心绽放了。。。 。。。有想法去实现~shixian.com"

Post.where(description: nil).each do |post|
  post.description = Faker::Lorem.paragraph(2)
  post.save
end

user_ids = User.ids
user_ids.each do |i|
  User.reset_counters(i, :posts)
end

t = Topic.last
t.essence = true
t.save

500.times do
  snippet = Snippet.create body: "rewrijwe jw joew oewjr w", topic: Topic.all.sample, user: User.all.sample, name: "hehe ...", spec: "16px", color: "黑金", per_price: Faker::Number.number(2), quantity: Faker::Number.number(1), address: "广西-桂林-临桂..."
end

Topic.find_each do |topic|
  topic.tag_list = Faker::Lorem.words.join(',')
  topic.save(validate: false)
end

400.times do
  jack = User.all.sample
  mary = User.all.sample

  jack.follow mary
  jack.create_activity :follow, owner: jack, recipient: mary
end

1000.times do
  from_user_id = User.ids.sample
  to_user_id = User.ids.sample
  if from_user_id != to_user_id
    DirectMessage.create(from_user_id: from_user_id, to_user_id: to_user_id, content: Faker::Lorem.paragraph)

    from_user = User.find from_user_id
    to_user = User.find to_user_id

    from_user.follow to_user
    from_user.create_activity :follow, owner: from_user, recipient: to_user
  end
end
