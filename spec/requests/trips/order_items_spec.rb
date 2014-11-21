require 'spec_helper'

describe "Order Item Pages" do
  
  before(:each) do
    company_default = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company_default)  
  end
  
  let!(:activity)           { create(:activity) }
  let!(:privacy_policy)     { create(:registration_agreement) }
  let!(:terms_of_service)   { create(:client_agreement) }
  let!(:cart_items)         { create(:order_item, order_id: nil) }

  describe "Order item new Page" do
    let!(:trip)       { create(:trip, title: "title") }
    let!(:trip_cost)  { create(:trip_cost, trip_id: trip.id) }
    
    context "when I visit the page" do
      it "should have the correct basic content" do
        visit new_trip_order_item_path(trip)
        expect(page).to have_content trip.title
        expect(page).to have_content trip.short_description
        expect(page).to have_content trip.description
        expect(page).to have_content trip.length_description
        expect(page).to have_content trip.difficulty
        expect(page).to have_content trip.time_of_year
        expect(page).to have_content trip.itinerary
        expect(page).to have_content trip.supplied_gear
        expect(page).to have_content trip.required_gear
        expect(page).to have_content trip.meeting_description
        expect(page).to have_content trip.company_name
        expect(page).to have_content trip.company_description
        expect(page).to have_content trip.refund_policy
      end
      
      context "when I am signed in" do
        
        before(:each) do
      		@user = create(:user)
      		login_as @user
        end
        
        context "when I make an appropriate selection and click add to cart" do
          
          it "should create an order item and take me to my cart" do
            3.times do |i|
              @trip_date = create(:trip_date, trip_id: trip.id, start_time: i.to_s )
            end      
            visit new_trip_order_item_path(trip)
            select(@trip_date.date_range_with_weekday, :from => "order_item_trip_date_id")
            fill_in "input_nop", with: 2
            allow_any_instance_of(OrderItem).to receive(:line_total).and_return(200)
            click_button "Add to cart"
            expect(current_path).to eq(cart_path(@user))
          end
          
        end
      end
      
      context "when I am not signed in" do

        context "when I make a selection and click add to cart" do
          
          it "should create an order item and take me to my cart" do
            3.times do |i|
              @trip_date = create(:trip_date, trip_id: trip.id, start_time: i.to_s )
            end      
            visit new_trip_order_item_path(trip)
            select(@trip_date.date_range_with_weekday, :from => "order_item_trip_date_id")
            fill_in "input_nop", with: 2
            click_button "Add to cart"
            expect(current_path).to eq(new_user_session_path)
          end
          
        end
        
      end
      
      context "when the trip has a guide", :slow do
        it "should have the guide profile" do
          visit new_trip_order_item_path(trip)
          expect(page).to have_selector ".guide-profile"
        end
      end
      
      context "when the trip does not have a guide", :slow do
        let!(:trip_ng)      { create(:trip, guide_id: nil, private: false, group: true) }
        let!(:trip_cost_ng) { create(:trip_cost, trip_id: trip_ng.id) }

        it "should not have the guide profile" do
          visit new_trip_order_item_path(trip_ng)
          expect(page).not_to have_selector ".guide-profile"
        end
      end

      context "when the trip has special directions", :slow do
        let!(:trip_sd)      { create(:trip, special_directions: "aaaaaaa") }
        let!(:trip_cost_sd) { create(:trip_cost, trip_id: trip_sd.id) }

        it "should show the special directions", :slow do
          visit new_trip_order_item_path(trip_sd)
          expect(page).to have_content "Special directions"
        end
      end

      context "when the trip does not have special directions", :slow do
        let!(:trip_nsd)      { create(:trip, special_directions: nil) }
        let!(:trip_cost_nsd) { create(:trip_cost, trip_id: trip_nsd.id) }

        it "should not show the special directions", :slow do
          visit new_trip_order_item_path(trip_nsd)
          expect(page).not_to have_content "Special directions"
        end
      end
      
    end
  end
  
end