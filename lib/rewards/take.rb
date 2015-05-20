module Rewards
	module Take
		extend self

		def say_hello
			puts "hello there, you have just been rewarded!"
		end

		def reward_for_viewing(viewer, post_id)
			puts "--------------------------------"
			puts "points have been deducted for viewing a post!"
			puts "--------------------------------"
			post = Post.find(post_id)
			author = User.find(post.user_id)
			reward(viewer.id, event: :viewing_post, description: "You viewed the post: #{post.title}, by #{author.name}", points: -1)
		end

		private
		def reward(user_id, params)
			Reward.new(params.merge(user_id: user_id)).save
		end
	end
end