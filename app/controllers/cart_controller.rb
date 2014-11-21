class CartController < ApplicationController
	before_action :confirm_signed_in

	def show
    @cart_items.each { |i| i.update({
      trip_cost_id: i.current_trip_cost.id,
      service_tax_rate: i.trip.service_tax
      }) }
	end
  
end