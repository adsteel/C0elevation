require 'spec_helper'

describe Admin::GuidesController, :type => :controller do

	before (:each) do
		@admin = create(:admin)
		@guide = create(:guide, user_id: @admin.id )
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
		it "renders the :show view" do
			get :show, id: @guide
			expect( response ).to render_template :show
		end
	end

	describe "GET #edit" do
		it "renders the :edit view" do
			get :edit, id: @guide
			expect( response ).to render_template :edit
		end
	end

	describe "POST create action" do
		let(:user)				{ FactoryGirl.create(:user) }
		let(:guide) 			{ FactoryGirl.attributes_for(:guide, user_id: user.id ) }
		
		let(:bad_guide) 		{ FactoryGirl.attributes_for(:bad_guide) }

		context "given valid attributes" do
			it "creates a new record" do
				expect{ post :create, guide: guide }.to change(Guide, :count).by(1)
			end
		end

		context "given invalid attributes" do
			it "re-renders the new method" do
				post :create, guide: bad_guide
				expect( response ).to render_template :new
			end

			it "does not save the new record" do
				expect{ post :create, guide: bad_guide }.to_not change(Guide, :count)
			end
		end

	end

	describe 'PUT update' do
		before :each do
			@guide = create(:guide, intro: "hey", bio: "hey")
		end

		context "valid attributes" do
			it "located the requested @guide" do
				put :update, id: @guide, guide: attributes_for(:guide)
				expect( assigns :guide ).to eq @guide
			end

			it "changes @guide's attributes" do
				put :update, id: @guide, guide: attributes_for(:guide, intro: "hey there")
				@guide.reload
				expect( @guide.intro ).to eq("hey there")
			end

			it "redirects to the updated guide" do
				put :update, id: @guide, guide: attributes_for(:guide)
				expect( response ).to redirect_to admin_guide_path(@guide)
			end

		end

		context "invalid attributes" do
			it "locates the requested @guide" do
				put :update, id: @guide, guide: attributes_for(:bad_guide)
				expect( assigns :guide ).to eq @guide
			end

			it "does not change @guide's attributes" do
				put :update, id: @guide, guide: attributes_for(:guide, user_id: nil, intro: "hey there")
				@guide.reload
				expect( @guide.user_id ).not_to eq(nil)
				expect( @guide.intro ).to eq("hey")
			end

			it "re-renders the edit method" do
				put :update, id: @guide, guide: attributes_for(:bad_guide)
				expect( response ).to render_template :edit
			end
		end
	end

end