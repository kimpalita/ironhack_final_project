class AddViewersandViewedPostsToViewings < ActiveRecord::Migration
  def change
  	add_reference :viewings, :viewed_post, references: :posts
  	add_reference :viewings, :viewer, references: :users
  end
end
