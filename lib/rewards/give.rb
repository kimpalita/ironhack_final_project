module Rewards
	module Give
		@@registration = 3
		@@publishing = 1
		@@receiving_view = 1
		
		extend self

		def say_hello
			puts "hello there, you have just been rewarded!"
		end

		def reward_for_registration(user)
     		puts "--------------------------------"
			puts "hello there, you have just been rewarded for REGISTRATION!"
			puts "--------------------------------"
			reward(user.id, event: :sign_up, description: "New user registration", points: @@registration)
		end

		def reward_for_publishing_post(user, post)
     		puts "--------------------------------"
			puts "hello there, you have just been rewarded for PUBLISHING POST!"
			puts "--------------------------------"
			reward(user.id, event: :published_post, description: "You published: #{post.title}", points: @@publishing)
		end

		def reward_for_receiving_view(viewer, post_id)
     		puts "--------------------------------"
			puts "hello there, you have just been rewarded for RECEIVING VIEW!"
			puts "--------------------------------"
			post = Post.find(post_id)
			user = User.find(post.user_id)
			reward(user.id, event: :recieved_view, description: "#{viewer.name} viewed your post: #{post.title}", points: @@receiving_view)
		end

		private
		def reward(user_id, params)
			Reward.new(params.merge(user_id: user_id)).save
		end
	end
end

=begin
def user_saw_post(user_id, post_id)
			user = User.find_by_id(user_id)
			post = Post.find_by_id(post_id)
			reward(user.id, description: "user saw a post", amount: -1, type: :post_checked)
		end

		def user_posted(user_id)
			user = User.find_by_id(user_id)
			reward(user.id, description: "user created a post", amount: +1, type: :post_created)
		end

		private
		def reward(user_id, params)
			Reward.new(params.merge(user_id: user_id)).save
			mail_me
		end
=end