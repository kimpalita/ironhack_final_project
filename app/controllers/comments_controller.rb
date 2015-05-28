class CommentsController < ApplicationController
	include Rewards::Give
	
	def create
		@post = Post.find(params[:id])
		@comment = @post.comments.create comment_params
		@comment.user_id = current_user.id
		if @comment.save
			Rewards::Give.notice_for_giving_comment(current_user, @post)
			Rewards::Give.notice_for_receiving_comment(current_user, @post) if @post.user_id != current_user.id
			redirect_to user_post_path
		else
			@comments = @post.comments.order(created_at: :desc)
			@post = Post.find(params[:id])
			render 'posts/show'
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:body)
	end
end
