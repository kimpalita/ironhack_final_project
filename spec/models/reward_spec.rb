require 'rails_helper'

include Rewards::Give
include Rewards::Spend

describe Reward, type: :model do
	let(:user) { create(:first_user)}
	let(:post) { user.posts.new(attributes_for(:first_post)) }
	
	it "User still has no rewards" do
		expect(user.rewards).to eq([])
	end

	it "User can earn an award for publishing post" do
		post.save
		reward_for_publishing_post(user, post)
		expect(user.rewards.count).to eq(1)
	end

	xit "User earns points for registration" do
		reward_for_registration(user1)
		expect(user1.rewards.first.points).to be_kind_of Integer
	end

	xit "Total points of a user can be calculated" do
		expect(user2.total_points).to eq(0)
	end

	xit "When user has points" do
		user3 = instance_double("User", name: "Leo")
		allow(user3).to receive(:total_points){3}
		user3.total_points
		expect(safe_to_spend?(user3)).to eq(true)
	end

	xit "when user has no points" do
		expect(safe_to_spend?(user2)).to eq(false)
	end

	
end