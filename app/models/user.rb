class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :posts
	has_many :rewards
	has_many :posts_viewed, :class_name => "Viewing", :foreign_key => "viewer_id"
	has_many :comments

	acts_as_voter

	validates :name, presence: true


	def total_points
		self.rewards.sum(:points)
	end

end