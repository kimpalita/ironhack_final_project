class Viewing < ActiveRecord::Base
	belongs_to :viewer, :class_name => 'User', :foreign_key => 'viewer_id'
	belongs_to :viewed_post, :class_name => 'Post', :foreign_key => 'viewed_post_id'

	validates :viewer_id, :viewed_post_id, presence: true
	validates :viewed_post_id, :uniqueness => {:scope => [:viewer_id]}
	validate :check_viewer_and_viewed_post

	def check_viewer_and_viewed_post
		viewer_id != viewed_post_id
	end
	
end
