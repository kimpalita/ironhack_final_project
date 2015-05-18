class Post < ActiveRecord::Base
	belongs_to :user
	has_many :post_viewers, :class_name => "Viewing", :foreign_key => "viewed_post_id"
end
