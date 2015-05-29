class ViewingsController < ApplicationController
	include Rewards::Give
	include Rewards::Spend
	

	def create
		if safe_to_spend?(current_user, VIEWING_POST)
			Viewing.where(viewer_id: current_user.id, viewed_post_id: params[:post_id]).first_or_create
			Rewards::Give.reward_for_receiving_view(current_user, params[:post_id])
			Rewards::Spend.reward_for_viewing(current_user, params[:post_id])
			redirect_to user_post_path(current_user.id, params[:post_id])
		
		else
			@posts = Post.all
			@viewed_posts = Post.already_viewed(current_user.id) if user_signed_in?
			@user = current_user

#			if user_signed_in?
#				@viewed_posts = @user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}.flatten
#			else
#				@viewed_posts = []
#			end
			flash.now[:alert] = "You do not have enough pennies to spend"
			render 'posts/index'
		end
	end
end
