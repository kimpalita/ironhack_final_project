class PostsController < ApplicationController
	include Rewards::Give
	include Rewards::Spend
	before_action :authenticate_user!, :except => [:index, :browse_keyword, :posts_by_author]


	def index
		@posts = Post.all.order(created_at: :desc)
		@viewed_posts = Post.already_viewed(current_user.id) if user_signed_in?
	end

	def filter
		@posts = Post.where(nil)
		#@posts = Post.author(params[:author]) if params[:author].present?
		#@posts = Post.keyword(params[:keyword]) if params[:keyword].present?
		#@posts = Post.already_viewed(params[:already_viewed]) if params[:already_viewed].present?
		#@posts = Post.not_yet_viewed(params[:not_yet_viewed]) if params[:not_yet_viewed].present?
		@viewed_posts = Post.already_viewed(current_user.id) if user_signed_in?
		filtering_params(params).each do |key, value|
		    @posts = @posts.public_send(key, value) if value.present?
		end
	end

	def sort
		@posts = Post.where(nil)
		@posts = Post.most_likes
		@posts = Post.most_views
		@viewed_posts = Post.already_viewed(current_user.id) if user_signed_in?
	end

	def show
		@user = current_user
		@post = Post.find(params[:id])
		@comments = @post.comments
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

	def filtering_params(params)
	  params.slice(:author, :keyword, :already_viewed, :not_yet_viewed)
	end

end
