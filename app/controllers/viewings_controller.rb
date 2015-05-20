class ViewingsController < ApplicationController
	def create
		Viewing.where(viewer_id: current_user.id, viewed_post_id: params[:post_id]).first_or_create
		redirect_to view_path
	end
end
