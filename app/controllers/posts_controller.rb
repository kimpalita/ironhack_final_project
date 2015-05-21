class PostsController < ApplicationController
	include Rewards::Give
	include Rewards::Spend
	before_action :authenticate_user!, :except => [:index, :browse_keyword]


	def index
		@posts = Post.all
		@user = current_user
		if user_signed_in?
			@viewed_posts = @user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}.flatten
		else
			@viewed_posts = []
		end
		#@posts = posts - viewed_posts
	end

	def browse_keyword
		@user = current_user
		@keyword = params[:keyword]
		@posts = Keyword.where(name: @keyword).map{|hash| Post.where('id=?', hash.post_id)}.flatten
		if user_signed_in?
			@viewed_posts = @user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}.flatten
		else
			@viewed_posts = []
		end
	end

	def my_posts
		@user = current_user
		@posts = @user.posts
	end

	def show
		@user = current_user
		@post = Post.find(params[:post_id])

		#Foo::Reward.user_saw_post(@user.id, @post.id)
	end

	def viewed
		@user = current_user
		@posts = @user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}.flatten
	end

	def new
		@user = current_user
		@post = Post.new
	end

	def create
		@post = current_user.posts.create post_params

		if @post.save
			@post.create_keywords
			Rewards::Give.reward_for_publishing_post(current_user, @post)
			redirect_to my_posts_path
		else
			render 'new'
		end
	end

	def delete
	end

	private

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
