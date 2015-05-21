require 'rails_helper'
#include Rewards::Spend

describe PostsController, type: :controller do
	render_views

	let(:user){create(:first_user)}
	
	it "get Index" do
		get :index
    	expect(response.status).to eq(200)
	end

	it "Sign in a user" do
		sign_in user
		get :index
    	expect(response).to be_success
	end

	it "Signed in user accessing posts" do
		sign_in user
		get :my_posts
    	expect(response).to be_success
	end

	it "if user not signed in and tries to access my_posts" do
		get :my_posts
    	expect(response).to redirect_to('/users/sign_in')
	end

end