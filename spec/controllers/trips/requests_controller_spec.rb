require 'spec_helper'

describe Trips::RequestsController, :type => :controller do

	before (:each) do
		@user = create(:user)
		sign_in @user
    company = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company)
    allow(Company).to receive(:logo_url) { "url" }
	end

	describe "POST #create" do
		let!(:trip)	{ create :trip }
    let!(:request) { attributes_for(:request) }
    let!(:company) { create :company, id: 4 }
		it "creates a new request" do
      expect{ post :create,  {request: request, trip_id: trip.id } }.to change(Request, :count).by(1)
		end
	end

end