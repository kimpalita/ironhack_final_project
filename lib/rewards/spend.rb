module Rewards
	module Spend
		VIEWING_POST = 2

		extend self

		def safe_to_spend?(user, event_reference)
			user.total_points >= event_reference
		end

		def reward_for_viewing(viewer, post_id)
			puts "--------------------------------"
			puts "points have been deducted for viewing a post!"
			puts "--------------------------------"
			post = Post.find(post_id)
			author = User.find(post.user_id)
			reward(viewer.id, event: :viewing_post, description: "You viewed the post: ", subject: nil, object: post_id, points: -VIEWING_POST)
		end

		private
		def reward(user_id, params)
			Reward.new(params.merge(user_id: user_id)).save
		end
	end
end