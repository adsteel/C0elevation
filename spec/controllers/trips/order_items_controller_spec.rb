require 'spec_helper'

describe Trips::OrderItemsController, :type => :controller do

	before (:each) do
		@user = create(:user)
		sign_in @user
    company = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company)
	end

	describe "GET #new" do
		let(:trip)	{ create :trip }

		it "renders the :new view" do
			get :new, :trip_id => trip.slug
			expect( response ).to render_template :new
		end
	end

	describe "POST create action" do
		let(:trip) 				      { create(:trip) }
		let(:trip_date) 		    { create(:trip_date) }
		let(:buyer) 			      { create(:buyer) }
		let(:company) 			    { create(:company) }
    let(:trip_cost)         { create(:trip_cost, trip_id: trip.id) }
	  let(:order_item)        { attributes_for(:order_item, trip_date_id: trip_date.id, buyer_id: buyer.id, company_id: company.id, trip_cost_id: trip_cost.id) }
	  let(:bad_order_item)    { attributes_for(:bad_order_item, trip_date_id: trip_date.id, buyer_id: buyer.id, company_id: company.id) }
 
		context "given valid order item attributes" do
			it "creates a new order item and redirects to cart" do  
				expect{ post :create,  {order_item: order_item, trip_id: trip.slug } }.to change(OrderItem, :count).by(1)
        expect( response ).to redirect_to cart_path( @user.slug )
			end
		end

		# context "given invalid order item attributes" do
		# 	it "re-renders the new method" do
		# 		post :create, {order_item: bad_order_item}, {"current_trip_id" => trip.id}
		# 		expect( response ).to render_template :new
		# 	end
		# end

	end
end
