require 'rails_helper'
include Rewards::Spend

describe Reward, type: :model do
	let(:user){create(:first_user)}

	it "user has no posts viewed" do
		expect(user.posts_viewed.count).to eq(0)
	end
end