class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :confirm_signed_in, except: [:new, :create]
	before_action :authenticate_admin, only: [:index]

	def index
		@users = User.all
	end


	def show
		@upcoming_client_trips = current_user.upcoming_client_trips
		@past_client_trips = current_user.past_client_trips
		@upcoming_guide_trips = current_user.upcoming_guide_trips
		@guide_trips_to_confirm = @upcoming_guide_trips.select{ |tr| tr.guide_confirmed == nil }
		@past_guide_trips = current_user.past_guide_trips
		@guide_posted_trips = Trip.where("guide_id" => current_user.id).select{ |t| t.active == true }
	end

	def apply
	end

	def new
		@user = User.new
	end

	def edit
	end


	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				format.html { redirect_to @user, notice: 'User was successfully created.' }
				format.json { render action: 'show', status: :created, location: @user }
			else
				format.html { render action: 'new' }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end


	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to @user, notice: 'User was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end


	def destroy
		@user.destroy
		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end

	def send_purchase_confirmation
		order = OrderItem.where("buyer_id = ?", current_user.id).last.order
		UserMailer.purchase_confirmation(current_user, order).deliver
		redirect_to current_user
	end

	def resend_trip_details
		order_item = OrderItem.where("buyer_id = ?", current_user.id).last
		UserMailer.resend_trip_details(current_user, order_item).deliver
		redirect_to current_user
	end

	private
		def set_user
			if params[:id]
				@user = User.friendly.find(params[:id])
			else
				@user = current_user
			end
		end

		def user_params
			params.require(:user).permit(	:admin,
											:guide_status,
											:first,
											:last,
											:email,
											:phone,
											:birthday,
											:gender,
											:street_address,
											:city,
											:state,
											:emergency_first,
											:emergency_last,
											:emergency_relationship,
											:emergency_phone,
											:emergency_email,
											:emergency_notes,
											:accept_tems)
		end
end
