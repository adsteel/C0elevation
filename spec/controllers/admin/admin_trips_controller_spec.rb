require 'spec_helper'

describe Admin::TripsController, :type => :controller do

	before (:each) do
		@admin = create(:admin)
		sign_in @admin
    company = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company)
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
		let(:trip) 				{ create(:trip) }
		it "renders the :show view" do
			get :show, id: trip
			expect( response ).to render_template :show
		end
	end

	describe "GET #edit" do
		let(:trip) 				{ create(:trip) }
		it "renders the :edit view" do
			get :edit, id: trip
			expect( response ).to render_template :edit
		end
	end

	describe "POST create action" do
		let(:activity) 			{ create(:activity) }
		let(:location) 			{ create(:location) }
		let(:company) 			{ create(:company) }
		let(:guide)				{ create(:guide) }

		let(:trip) 				{ attributes_for(:trip, activity_id: activity.id, location_id: location.id, company_id: company.id, guide_id: guide.id) }
		let(:bad_trip) 			{ attributes_for(:trip, location_id: location.id, company_id: company.id, guide_id: guide.id) }

		context "given valid attributes" do
			it "creates a new record" do
				expect{ post :create, trip: trip }.to change(Trip, :count).by(1)
			end
		end

		context "given invalid attributes" do
			it "re-renders the new method" do
				post :create, trip: bad_trip
				expect( response ).to render_template :new
			end

			it "does not save the new record" do
				expect{ post :create, trip: bad_trip }.to_not change(Trip, :count)
			end
		end
	end

	describe 'PUT update' do
		before :each do
			@trip = create(:trip, title: "Old Title", description: "Old Description", one_liner: "Old one liner")
		end

		context "valid attributes" do
			it "located the requested @trip" do
				put :update, id: @trip, trip: attributes_for(:trip)
				expect( assigns :trip ).to eq @trip
			end

			it "changes @trip's attributes" do
				put :update, id: @trip, trip: attributes_for(:trip, title: "New Title", description: "New Description")
				@trip.reload
				expect( @trip.title ).to eq("New Title")
				expect( @trip.description ).to eq("New Description")
			end

			it "redirects to the updated trip" do
				put :update, id: @trip, trip: attributes_for(:trip)
				expect( response ).to redirect_to admin_trip_path(@trip)
			end

		end

		context "invalid attributes" do
			it "locates the requested @trip" do
				put :update, id: @trip, trip: attributes_for(:bad_trip)
				expect( assigns :trip ).to eq @trip
			end

			it "does not change @trip's attributes" do
				put :update, id: @trip, trip: attributes_for(:trip, title: "New Title", description: nil)
				@trip.reload
				expect( @trip.title ).not_to eq("New Title")
				expect( @trip.description ).to eq("Old Description")
			end

			it "re-renders the edit method" do
				put :update, id: @trip, trip: attributes_for(:bad_trip)
				expect( response ).to render_template :edit
			end
		end
	end

end