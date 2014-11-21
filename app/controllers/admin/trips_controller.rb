class Admin::TripsController < ApplicationController
	before_action :confirm_signed_in
	before_action :set_trip, only: [:show, :edit, :update, :destroy]
	before_filter :set_trip_variables, only: [:edit, :new, :create, :update]
	before_action :authenticate_admin


	def index
		@trips = Trip.where(active: true)
	end


	def show
		session[:current_trip_id] = @trip.id
		@last_images = @trip.images.last(3)
		@last_dates = @trip.trip_dates.last(3)
		@cost_columns = TripCost::COSTCOLUMNS
    @trip_cost = @trip.trip_costs.last
	end


	def new
		@trip = Trip.new
	end


	def edit
	end


	def create
		@trip = Trip.new(trip_params)
		@trip.difficulty = params[:trip][:difficulty].to_s
		respond_to do |format|
			if @trip.save
				session[:current_trip_id] = @trip.id 
				format.html { redirect_to admin_trip_path(@trip), notice: 'Trip was successfully created. Please add dates.' }
				format.json { render action: 'show', status: :created, location: @trip }
			else
				format.html { render action: 'new' }
				format.json { render json: @trip.errors, status: :unprocessable_entity }
			end
		end
	end


	def update
		respond_to do |format|
			if @trip.update(trip_params)
				format.html { redirect_to admin_trip_path(@trip), notice: 'Trip was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @trip.errors, status: :unprocessable_entity }
			end
		end
	end


	def destroy
		@trip.update({ :active => false })
		respond_to do |format|
			format.html { redirect_to admin_trips_path }
			format.json { head :no_content }
		end
	end

	private

		def set_trip_variables
			@activities = Activity.all
			@difficulties = Trip::DIFFICULTIES.collect { |i| i.to_s }
			@lengths = Trip::LENGTHS.collect { |i| i.to_s }
			@skills = Trip::SKILLS.collect { |i| i.to_s }
			@locations = Location.all
			@guides = Guide.all
			@companies = Company.all
		end

		def set_trip
			@trip = Trip.friendly.find(params[:id])
		end

		def trip_params
			params.fetch(:trip, {}).permit(	
				:activity_id,
				:guide_id,
				:difficulty_id,
				:length,
				:location_id,
				:route_id,
				:feature_id,
				:latitude,
				:longitude,
				:meet_address,
				:required_gear,
				:supplied_gear,
				:special_directions,
				:offer_capacity,
				:trip_length_id,
				:description,
				:itinerary,
				:company_id,
				:first_person_cost,
				:second_person_cost,
				:guide_rate,
				:min,
				:max,
				:service_tax,
				:time_of_year,
				:course,
				:group,
				:private,
				:title,
				:active,
				:meeting_time,
				:length_description,
				:meeting_description,
				:one_liner,
				:short_description,
				:skill_level,
        :refund_policy)
		end

		def confirm_authorized
			if current_user && current_user.admin? && current_user.id == @trip.guide.user_id
				return true
			else
				redirect_to profile_path
			end
		end
end
