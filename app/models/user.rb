class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :posts
	has_many :rewards
	has_many :posts_viewed, :class_name => "Viewing", :foreign_key => "viewer_id"

	validates :name, presence: true

end