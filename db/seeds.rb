# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)

a = User.create name: "Kim"
b = User.create name: "Mark"
c = User.create name: "Tim"
d = User.create name: "Leo"

User.all.map do |user|
	user.posts.create(title: "#{user.name}s First Post", content: "#{user.name}s First Post Content")
end

User.all.map do |user|
	user.posts.create(title: "#{user.name}s Second Post", content: "#{user.name}s Second Post Content")
end

User.all.map do |user|
	user.posts.create(title: "#{user.name}s Third Post", content: "#{user.name}s Third Post Content")
end

a.posts_viewed.create(viewed_post_id: "2")
a.posts_viewed.create(viewed_post_id: "3")
a.posts_viewed.create(viewed_post_id: "4")

b.posts_viewed.create(viewed_post_id: "5")
b.posts_viewed.create(viewed_post_id: "8")