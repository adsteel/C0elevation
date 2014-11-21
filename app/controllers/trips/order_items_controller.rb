class Trips::OrderItemsController < ApplicationController
	before_action :get_order_item_from_friendly_param, only: [:show, :edit, :update, :destroy]
  before_action :get_related_variables, only: [:new, :create, :ajax_dates]
	before_filter :get_trip, :set_user
	before_filter :confirm_signed_in, except: [:new, :ajax_dates, :ajax_calc_total]
	before_action :confirm_authorized, only: [:destroy, :edit, :update]

	def show
		session[:current_order_item_id] = @order_item.id
	end

	def new
		@order_item 					      = OrderItem.new
    get_related_variables
		session[:current_trip_id] 	= @trip.id
	end

	def edit
		@order_item = OrderItem.friendly.find(params[:id])
		session[:current_order_item_id] = @order_item.id
		session[:original_trip_attendance] = @order_item.trip_attendance.to_s
	end

	def create
    get_related_variables
		@order_item                    = OrderItem.new(order_item_params)
		@order_item.buyer_id           = current_user.id
		@order_item.company_id         = @trip.company_id
		@order_item.trip_id            = @trip.id
		@order_item.trip_cost_id       = @trip.last_trip_cost.id
    @order_item.service_tax_rate   = @trip.service_tax

		if @order_item.save
			just_created = OrderItem.last
			just_created.sames.where('buyer_id = ?', current_user.id).where('created_at < ?', just_created.created_at).destroy_all
			redirect_to cart_path(current_user), notice: 'Your trip has been added to your cart.'
		else
			render 'new', notice: 'We were unable to customize your trip.'
		end
	end

	def destroy
		@order_item.destroy
		respond_to do |format|
			format.html { 
        if @cart_items.length <= 1
          redirect_to home_path
        else
          redirect_to cart_path(current_user)
        end
      }
			format.json { head :no_content }
		end
	end

  def ajax_calc_total
    @nop      = params[:nop]
    @services = @trip.services_total(@nop)
    @tax      = @trip.tax_total(@nop)
    @grand    = @services + @tax
    @params   = params
  end
  
  def ajax_dates
    @id    = params[:id]
    @dates = dates_with_max
    @dates.each do |d|
      @new_max = d[:new_max] if d[:id].to_i == @id.to_i
    end
  end

private
	def order_item_params
		params.fetch(:order_item, {}).permit(	
			:order_id,
			:company_id,
			:trip_id,
			:trip_date_id,
			:number_of_people,
			:buyer_id,
			:first_person_cost,
			:second_person_cost,
			:stripe_charge_id )
	end

	def get_order_item_from_friendly_param
		@order_item = OrderItem.friendly.find(params[:id])
	end
  
  def get_trip
    @trip = Trip.friendly.find(params[:trip_id])
  end
  
  def dates_with_max
    @dates = @trip_dates.map{ |d| {id: d.id, new_max: @trip.max - d.potential_attendance} }
  end

	def confirm_authorized
		confirm_signed_in
		unless (current_user.id == @order_item.buyer_id or current_user.admin?) then redirect_to cart_path end
	end
  
  def get_related_variables
    @trip                  = Trip.friendly.find(params[:trip_id])
		@images							   = @trip.images.where(ratio: "3x2").reject{ |i| i.id == @trip.primary_image_id }
		@unavailable_date_ids  = @trip.guide ? @trip.guide.unavailable_dates.map { |e| e.id } : []
		@trip_dates 				   = TripDate.where(trip_id: @trip.id).reject { |td| @unavailable_date_ids.include? td.id or td.start_date < Date.today + 3 or td.booked? }
		@request 						   = Request.new
  end
				
end
