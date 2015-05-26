class PostsController < ApplicationController
	include Rewards::Give
	include Rewards::Spend
	before_action :authenticate_user!, :except => [:index, :browse_keyword, :posts_by_author]


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

	def posts_by_author
		@user = User.find(params[:user_id])
		@posts = @user.posts
		if user_signed_in?
			@viewed_posts = current_user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}.flatten
		else
			@viewed_posts = []
		end
	end

	def show
		@user = current_user
		@post = Post.find(params[:id])
		@comments = @post.comments
		#Foo::Reward.user_saw_post(@user.id, @post.id)
		@comment = Comment.new
	end

	def viewed
		@user = current_user
		@posts = @user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}.flatten
	end

	def my_posts
		@user = current_user
		@posts = @user.posts
	end

	def new
		@user = current_user
		@post = @user.posts.new
	end

	def create
		@post = current_user.posts.new post_params
		if @post.save
			@post.create_keywords
			Rewards::Give.reward_for_publishing_post(current_user, @post)
			redirect_to user_post_path(current_user.id, @post.id)
		else
			#@user = current_user
			#@post = current_user.posts.new post_params
			render :new
		end
	end

	def like
	  @user = current_user
	  @post = Post.find(params[:id])
	  unless @user.voted_for? @post
	  	@post.liked_by current_user
	  	Rewards::Give.reward_for_receiving_like(current_user, @post)
	  end
	  render 'show'
	end

	def dislike
		@user = current_user
	  	@post = Post.find(params[:id])
	  	@post.disliked_by current_user
	  	render 'show'
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to my_posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :content)
	end


end
