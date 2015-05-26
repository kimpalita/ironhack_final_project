module UsersHelper

	def render_reward(reward)
		return render("shared/with_object", reward: reward) if !reward.object.nil?
		return render("shared/test", reward: reward) 
	end
end


