# require 'spec_helper'

# RSpec.describe "trip_costs/new", :type => :view do
#   before(:each) do
#     assign(:trip_cost, TripCost.new(
#       :trip_id => 1,
#       :one => 1,
#       :two => 1,
#       :three => 1,
#       :four => 1,
#       :five => 1,
#       :six => 1,
#       :seven => 1,
#       :eight => 1,
#       :nine => 1,
#       :ten => 1
#     ))
#   end

#   it "renders new trip_cost form" do
#     render

#     assert_select "form[action=?][method=?]", trip_costs_path, "post" do

#       assert_select "input#trip_cost_trip_id[name=?]", "trip_cost[trip_id]"

#       assert_select "input#trip_cost_one[name=?]", "trip_cost[one]"

#       assert_select "input#trip_cost_two[name=?]", "trip_cost[two]"

#       assert_select "input#trip_cost_three[name=?]", "trip_cost[three]"

#       assert_select "input#trip_cost_four[name=?]", "trip_cost[four]"

#       assert_select "input#trip_cost_five[name=?]", "trip_cost[five]"

#       assert_select "input#trip_cost_six[name=?]", "trip_cost[six]"

#       assert_select "input#trip_cost_seven[name=?]", "trip_cost[seven]"

#       assert_select "input#trip_cost_eight[name=?]", "trip_cost[eight]"

#       assert_select "input#trip_cost_nine[name=?]", "trip_cost[nine]"

#       assert_select "input#trip_cost_ten[name=?]", "trip_cost[ten]"
#     end
#   end
# end
