module ControllersHelper

	def set_user
		@user = current_user
	end

  # environment checkers

	def staging?
		request.original_url.include? "staging.coelevation.com"
	end

	def local_machine?
		request.original_url.include? "localhost:"
	end

	def cart?
		request.original_url.include? "cart/"
	end

  # setting variables

	def set_trip
		@trip = Trip.friendly.find_by_id(session[:current_trip_id])
	end

	def current_order_item_from_session
		@order_item = OrderItem.find_by_id(session[:current_order_item_id])
	end

	def set_new_attendance
		@new_attendance = session[:new_attendance].to_i
	end		

  # storing current states

	def store_trip
		session[:current_trip_id] = params[:trip_id]
	end

end