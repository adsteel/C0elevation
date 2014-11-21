class Trips::TripCostsController < ApplicationController
  before_action :get_trip
  before_action :set_trip_cost, only: [:show, :edit, :update, :destroy]

  def index
    @trip_costs = TripCost.all
  end

  def show
  end

  def new
    @trip_cost = TripCost.new
  end

  def edit
  end

  def create
    @trip_cost          = TripCost.new(trip_cost_params)
    @trip_cost.trip_id  = @trip.id

    respond_to do |format|
      if @trip_cost.save
        format.html { redirect_to trip_trip_cost_path(@trip, @trip_cost), notice: 'Trip cost was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trip_cost }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @trip_cost = TripCost.new
    @trip_cost.update(trip_cost_params)
    @trip_cost.trip_id = @trip.id

    respond_to do |format|
      if @trip_cost.save
        format.html { redirect_to trip_trip_cost_path(@trip, @trip_cost), notice: 'Trip cost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_trip_cost
      @trip_cost = TripCost.find(params[:id])
    end

    def get_trip
      @trip = Trip.friendly.find(params[:trip_id])
    end

    def trip_cost_params
      params.require(:trip_cost).permit(
        :trip_id, 
        :one, 
        :two, 
        :three, 
        :four, 
        :five, 
        :six, 
        :seven, 
        :eight, 
        :nine,
        :ten)
    end
end
