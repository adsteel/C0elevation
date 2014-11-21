require 'spec_helper'

describe Admin::LocationsController, :type => :controller do

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
		let(:location) 		{ FactoryGirl.create(:location) }
		it "renders the :show view" do
			get :show, id: location
			expect( response ).to render_template :show
		end
	end

	describe "GET #edit" do
		let(:location) 		{ FactoryGirl.create(:location) }
		it "renders the :edit view" do
			get :edit, id: location
			expect( response ).to render_template :edit
		end
	end

	describe "POST create action" do
		let(:location) 			{ FactoryGirl.attributes_for(:location) }
		let(:bad_location) 		{ FactoryGirl.attributes_for(:bad_location) }

		context "given valid attributes" do
			it "creates a new record" do
				expect{ post :create, location: location }.to change(Location, :count).by(1)
			end
		end

		context "given invalid attributes" do
			it "re-renders the new method" do
				post :create, location: bad_location
				expect( response ).to render_template :new
			end

			it "does not save the new record" do
				expect{ post :create, location: bad_location }.to_not change(Location, :count)
			end
		end

	end


end