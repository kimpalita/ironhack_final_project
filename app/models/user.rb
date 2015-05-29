class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :posts, dependent: :destroy
	has_many :rewards
	has_many :posts_viewed, :class_name => "Viewing", :foreign_key => "viewer_id"
	has_many :comments, dependent: :destroy

	has_attached_file :avatar, styles: { thumb: "16x16", small: "32x32", medium: "48x48" }, :default_url => ":style/default_avatar.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	validates :name, presence: true, length: { minimum: 2, maximum: 12 }

	acts_as_voter

	def total_points
		self.rewards.sum(:points)
	end



end