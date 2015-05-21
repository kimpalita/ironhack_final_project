module Rewards
	module Spend
		extend self

		def say_hello
			puts "hello there, you have just been rewarded!"
		end

		def safe_to_spend?(user, event_reference) #add callback to argument
			user.total_points >= event_reference #need more algorithm once further point system is developed
		end

		def reward_for_viewing(viewer, post_id)
			puts "--------------------------------"
			puts "points have been deducted for viewing a post!"
			puts "--------------------------------"
			post = Post.find(post_id)
			author = User.find(post.user_id)
			reward(viewer.id, event: :viewing_post, description: "You viewed the post: #{post.title}, by #{author.name}", points: -viewing)
		end

		private
		def reward(user_id, params)
			Reward.new(params.merge(user_id: user_id)).save
		end

		def viewing
			1
		end
	end
end