require 'rails_helper'
include Rewards::Spend

describe ViewingsController, type: :controller do
	let(:user){create(:first_user)}

	xit "user has no posts viewed" do
		expect(user.posts_viewed.count).to eq(0)
	end
end