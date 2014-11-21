require 'spec_helper'

describe Admin::ActivitiesController, :type => :controller do

	before (:each) do
		@admin = create(:admin)
		sign_in @admin
	end

	describe "GET #index" do
		it "renders the :index view" do
			get :index
			expect( response ).to render_template :index
		end
	end

	describe "GET #new" do
		it "renders the :new view" do
			get :new
			expect( response ).to render_template :new
		end
	end

	describe "GET #show" do
		let(:activity) 		{ FactoryGirl.create(:activity) }
		it "renders the :show view" do
			get :show, id: activity
			expect( response ).to render_template :show
		end
	end

	describe "GET #edit" do
		let(:activity) 		{ FactoryGirl.create(:activity) }
		it "renders the :edit view" do
			get :edit, id: activity
			expect( response ).to render_template :edit
		end
	end

	describe "POST create action" do
		let(:activity) 			{ FactoryGirl.attributes_for(:activity) }
		let(:bad_activity) 		{ FactoryGirl.attributes_for(:bad_activity) }

		context "given valid attributes" do
			it "creates a new record" do
				expect{ post :create, activity: activity }.to change(Activity, :count).by(1)
			end
		end

		context "given invalid attributes" do
			it "re-renders the new method" do
				post :create, activity: bad_activity
				expect( response ).to render_template :new
			end

			it "does not save the new record" do
				expect{ post :create, activity: bad_activity }.to_not change(Activity, :count)
			end
		end

	end

	describe 'PUT update' do
		before :each do
			@activity = create(:activity, title: "Singin")
		end

		context "valid attributes" do
			it "located the requested @activity" do
				put :update, id: @activity, activity: attributes_for(:activity)
				expect( assigns :activity ).to eq @activity
			end

			it "changes @activity's attributes" do
				put :update, id: @activity, activity: attributes_for(:activity, title: "Wallowin")
				@activity.reload
				expect( @activity.title ).to eq("Wallowin")
			end

			it "redirects to the updated activity" do
				put :update, id: @activity, activity: attributes_for(:activity)
				expect( response ).to redirect_to admin_activity_path(@activity)
			end

		end

		context "invalid attributes" do
			it "locates the requested @activity" do
				put :update, id: @activity, activity: attributes_for(:bad_activity)
				expect( assigns :activity ).to eq @activity
			end

			it "does not change @activity's attributes" do
				put :update, id: @activity, activity: attributes_for(:activity, title: nil)
				@activity.reload
				expect( @activity.title ).not_to eq(nil)
				expect( @activity.title ).to eq("Singin")
			end

			it "re-renders the edit method" do
				put :update, id: @activity, activity: attributes_for(:bad_activity)
				expect( response ).to render_template :edit
			end
		end
	end

end