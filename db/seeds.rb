# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)


a = User.create name: "PennyBot", email: "bot@mail.com", password: "12345678", password_confirmation: "12345678"

a.posts.create(title: "TV Finales", content: "The award-winning AMC series Mad Men ended its seven-season run on Sunday night and drew critical acclaim for its final episode, a conclusion that many felt was poignant and satisfying. Here are some other memorable TV finales across the years.")

a.posts.create(title: "Avengers Sequel", content: "Promising that the sequel would continue to follow the impressive feats of an incredible group of revenue streams, executives at Marvel Studios confirmed Friday that Avengers: Age Of Ultron picks up right where the first film’s profits left off.")
a.posts.create(title: "Repeated keywords", content: "In this text, there may be some recurring keywords. Age Of Ultron picks up right where the first film’s profits left off.")
a.posts.create(title: "The Sequel", content: "Of course, this film is going to leave the door wide open for possible future Avengers movie profits, and we might even explore the option of earning income from each individual character.” Feige added that careful observers would notice how ticket sale proceeds from the Avengers, Captain America, and Iron Man films were all connected.")

#a.posts_viewed.create(viewed_post_id: "2")
#a.posts_viewed.create(viewed_post_id: "3")
#a.posts_viewed.create(viewed_post_id: "4")
#
#b.posts_viewed.create(viewed_post_id: "5")
#b.posts_viewed.create(viewed_post_id: "8")
#
Post.all.each { |post| post.create_keywords }

