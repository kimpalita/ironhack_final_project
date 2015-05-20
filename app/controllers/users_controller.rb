class UsersController < ApplicationController
	before_action :authenticate_user!

	#def index
	#	users = User.all
	#	render json: users
	#end

	def show
		@rewards = current_user.rewards
		@total_points = current_user.total_points
	end

end
