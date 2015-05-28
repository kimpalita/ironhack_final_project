module Rewards
	module Give
		extend self

		PUBLISHING_POINTS   = 1
		RECEIVE_LIKE_POINTS = 1
		RECEIVE_VIEW_POINTS = 1
		REGISTRATION_POINTS = 3
		
		def say_hello
			puts "hello there, you have just been rewarded!"
		end

		def reward_for_registration(user)
			reward(user.id, event: :sign_up, description: "You created an account!",
				subject: nil, object: nil, points: REGISTRATION_POINTS)
		end

		def reward_for_publishing_post(user, post)
			reward(user.id, event: :published_post, description: "You published a post: ",
				subject: nil, object: post.id, points: PUBLISHING_POINTS)
		end

		def reward_for_receiving_view(viewer, post_id)
			post = Post.find(post_id)
			user = User.find(post.user_id)
			reward(user.id, event: :recieved_view, description: " viewed your post: ",
				subject: viewer.id, object: post_id, points: nil)
		end

		def reward_for_receiving_like(viewer, post_id)
     		puts "--------------------------------"
			puts "hello there, you have just been rewarded for RECEIVING LIKE!"
			puts "--------------------------------"
			post = Post.find(post_id)
			user = User.find(post.user_id)
			reward(user.id, event: :received_like, description: " liked your post: ",
				subject: viewer.id, object: post.id, points: RECEIVE_LIKE_POINTS)
		end

		def notice_for_receiving_comment(commentor, post)
			user = User.find(post.user_id)
			reward(user.id, event: :received_comment, description: " commented on your post: ",
				subject: commentor.id, object: post.id, points: nil)
		end

		def notice_for_giving_comment(commentor, post)
			user = User.find(commentor.id)
			reward(user.id, event: :gave_comment, description: "You commented on the post: ",
				subject: nil, object: post.id, points: nil)
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