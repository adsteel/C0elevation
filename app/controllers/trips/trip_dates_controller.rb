class Trips::TripDatesController < ApplicationController
	before_action :get_trip_date, only: [:show, :destroy]
	before_action :get_trip
	before_action :authenticate_admin


	def index
		@trip_dates = @trip.trip_dates
	end

	def new
		@trip_date = TripDate.new
		@trip_dates = @trip.trip_dates
	end

	def create
		@trip_date = TripDate.new(trip_date_params)
		@trip_date.trip_id = @trip.id

		if @trip_date.end_date.blank?
			@trip_date.end_date = @trip_date.start_date
		end

	    respond_to do |format|
	      if @trip_date.save
	        format.html { redirect_to new_trip_trip_date_path(@trip), notice: @trip_date.date_range + " was successfully added to this trip." }
	        format.json { render action: 'show', status: :created, location: @feature }
	      else
	        format.html { render action: 'new' }
	        format.json { render json: @feature.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
		@trip_date.destroy
		respond_to do |format|
			format.html { redirect_to trip_trip_dates_path }
			format.json { head :no_content }
		end
	end

	private
		def get_trip_date
			@trip_date = TripDate.find(params[:id])
		end

		def get_trip
			@trip = Trip.friendly.find(params[:trip_id])
		end

		def trip_date_params
			params.require(:trip_date).permit(
				:trip_id, 
				:start_date, 
				:end_date,
				:start_time
				)
		end
end
