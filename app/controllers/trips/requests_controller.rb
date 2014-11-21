class Trips::RequestsController < ApplicationController
before_filter :get_trip

	def create
		@request = Request.new(request_params)
		@request.user_id = current_user.id if current_user
    @request.trip_id = @trip.id
		@request.save
		UserMailer.request_confirmation(@trip, @request).deliver
		redirect_to new_trip_order_item_path(@trip)
	end


private

	def get_trip
		@trip = Trip.friendly.find(params[:trip_id])
	end

	def request_params
		params.require(:request).permit(
			:message, 
			:email, 
			:name,
      :trip_id,
			:requested_attendance)
	end

end
