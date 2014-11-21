# require 'spec_helper'

# RSpec.describe "trip_costs/index", :type => :view do
#   before(:each) do
#     assign(:trip_costs, [
#       TripCost.create!(
#         :trip_id => 1,
#         :one => 2,
#         :two => 3,
#         :three => 4,
#         :four => 5,
#         :five => 6,
#         :six => 7,
#         :seven => 8,
#         :eight => 9,
#         :nine => 10,
#         :ten => 11
#       ),
#       TripCost.create!(
#         :trip_id => 1,
#         :one => 2,
#         :two => 3,
#         :three => 4,
#         :four => 5,
#         :five => 6,
#         :six => 7,
#         :seven => 8,
#         :eight => 9,
#         :nine => 10,
#         :ten => 11
#       )
#     ])
#   end

#   it "renders a list of trip_costs" do
#     render
#     assert_select "tr>td", :text => 1.to_s, :count => 2
#     assert_select "tr>td", :text => 2.to_s, :count => 2
#     assert_select "tr>td", :text => 3.to_s, :count => 2
#     assert_select "tr>td", :text => 4.to_s, :count => 2
#     assert_select "tr>td", :text => 5.to_s, :count => 2
#     assert_select "tr>td", :text => 6.to_s, :count => 2
#     assert_select "tr>td", :text => 7.to_s, :count => 2
#     assert_select "tr>td", :text => 8.to_s, :count => 2
#     assert_select "tr>td", :text => 9.to_s, :count => 2
#     assert_select "tr>td", :text => 10.to_s, :count => 2
#     assert_select "tr>td", :text => 11.to_s, :count => 2
#   end
# end
