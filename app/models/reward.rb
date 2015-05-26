class Reward < ActiveRecord::Base
	EVENT_SIGN_UP = :sign_up
	belongs_to :user

	def signup?
		self.event == EVENT_SIGN_UP
	end
end
