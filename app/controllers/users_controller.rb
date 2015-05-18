class UsersController < ApplicationController
	def index
		users = User.all
		render json: users
	end

	def user
		user = User.where(id: params[:id])
		render json: user
	end

	def browse
		user = User.find(params[:id])
		viewed_posts = user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}
		unviewed_posts = Post.where(post_viewers.map{|viewer| 'viewer_id!=?', params[:id]})
		posts = Post.where.not(user_id: params[:id])

		render json: viewed_posts
	end

	def posts
		user = User.find(params[:id])
		posts = user.posts
		render json: posts
	end

	def viewed
		user = User.find(params[:id])
		viewed_posts = user.posts_viewed.map {|post| Post.where('id=?', post.viewed_post_id)}
		render json: viewed_posts
	end
end
