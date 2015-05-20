class ViewingsController < ApplicationController
	include Rewards::Give
	include Rewards::Take

	def create
		Viewing.where(viewer_id: current_user.id, viewed_post_id: params[:post_id]).first_or_create
		Rewards::Give.reward_for_recieving_view(current_user, params[:post_id])
		Rewards::Take.reward_for_viewing(current_user, params[:post_id])
		redirect_to view_path
	end
end
