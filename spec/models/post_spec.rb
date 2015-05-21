require 'rails_helper'

describe Post, type: :model do
	let(:user) { create(:first_user)}
	let(:post) { user.posts.new(attributes_for(:first_post)) }

	it "user id" do
		#binding.pry
		expect(user.id).to eq(1)
	end

	it "to belong to user" do
		#binding.pry
		post.save
		expect(user.posts.count).to eq(1)
	end

	it "has a create_keywords method" do
		post.save
		user.posts[0].create_keywords
		expect(post.keywords[0].name).to be_kind_of String
	end

	it "extract_keywords produces an array of strings" do		
		post.save
		user.posts[0].create_keywords
		keywords = user.posts[0].extract_keywords
		expect(keywords).to be_kind_of Array
	end
end