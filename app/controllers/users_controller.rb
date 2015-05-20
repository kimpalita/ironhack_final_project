class UsersController < ApplicationController
	before_action :authenticate_user!

	#def index
	#	users = User.all
	#	render json: users
	#end

	def show
		#binding.pry
	end

end
