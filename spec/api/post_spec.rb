require 'rails_helper'

describe Post, type: :model do
	let(:user1) { User.create(id: 1, name: "Kim")}
	let(:post1) { user1.posts.create(title: "A joke", content: "Man walked into a bar and said ouch.")}

	it "has an create_keywords method" do
		expect(post1.create_keywords).to be_kind_of Array
	end

	it "shows only posts that have not been created by the user" do		
		posts = Post.where.not(user_id: user1.id)
		expect(posts.size).to eq(0)
	end

	it "has an extract_keywords method" do		
		post1.create_keywords
		expect(post1.extract_keywords).to be_kind_of Array
	end

	it "extract_keywords produces an array of string" do		
		post1.create_keywords
		keywords = post1.extract_keywords
		expect(keywords[0]).to be_kind_of String
	end
end