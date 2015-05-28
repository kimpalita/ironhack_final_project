module UsersHelper
	def render_subject_for(reward)
		if User.where(id: reward.subject).exists?
			link_to(link_to User.find(reward.subject).name, filter_post_path(:author => reward.subject))
		else
			"<span class='non-existent'>User no longer exists</span>".html_safe
		end
	end

	def render_object_for(reward)
		if Post.where(id: reward.object).exists?
			link_to(link_to Post.find(reward.object).title, filter_post_path(:author => reward.object))
		else
			"<span class='non-existent'>Post no longer exists</span>".html_safe
		end
	end
end

=begin
def render_reward(reward)
		return render("shared/with_subject_and_object") if !reward.object.nil? && !reward.object.nil?
		return render("shared/with_object", reward: reward) if !reward.object.nil?
		return render("shared/test", reward: reward) 
	end
=end


