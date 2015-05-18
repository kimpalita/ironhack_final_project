class User < ActiveRecord::Base
	has_many :posts
	has_many :posts_viewed, :class_name => "Viewing", :foreign_key => "viewer_id"
end