class Viewing < ActiveRecord::Base
	belongs_to :viewer, :class_name => 'User', :foreign_key => 'viewer_id'
	belongs_to :viewed_post, :class_name => 'Post', :foreign_key => 'viewed_post_id'
	
end
