# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)

a = User.create name: "Kim", email: "kim@mail.com", password: "12345678", password_confirmation: "12345678"
b = User.create name: "Mark", email: "mark@mail.com", password: "12345678", password_confirmation: "12345678"
c = User.create name: "Jas", email: "jas@mail.com", password: "12345678", password_confirmation: "12345678"


a.posts.create(title: "#{a.name}'s First Post", content: "Words are but wind; and learning is nothing but words; ergo, learning is nothing but wind.")

b.posts.create(title: "#{b.name}'s Second Post", content: "I’ve missed more than 9000 shots in my career. I’ve lost almost 300 games. 26 times I’ve been trusted to take the game winning shot and missed. I’ve failed over and over and over again in my life. And that is why I succeed.")

c.posts.create(title: "#{c.name}'s Third Post", content: "Twenty years from now you will be more disappointed by the things that you didn’t do than by the ones you did do, so throw off the bowlines, sail away from safe harbor, catch the trade winds in your sails.  Explore, Dream, Discover.")

#
#a.posts_viewed.create(viewed_post_id: "2")
#a.posts_viewed.create(viewed_post_id: "3")
#a.posts_viewed.create(viewed_post_id: "4")
#
#b.posts_viewed.create(viewed_post_id: "5")
#b.posts_viewed.create(viewed_post_id: "8")
#
Post.all.each { |post| post.create_keywords }