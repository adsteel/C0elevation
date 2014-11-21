class OrderItemUpdatesController < ApplicationController
	before_action :current_order_item_from_session, except: [:confirm_guide]
	before_action :confirm_authorized, except: [:confirm_guide]
	before_action :confirm_user_is_guide, only: [:confirm_guide]
	before_action :set_new_attendance, except: [:edit_redirect, :confirm_guide]
	before_action :define_attendance_difference, except: [:edit_redirect, :confirm_guide]

	def confirm_guide
		@order_item = OrderItem.friendly.find(params[:id])
		@order_item.sames.each { |oi| oi.update({ :guide_confirmed => Time.now, :confirmed_by_user_id => current_user.id }) }
		if @order_item.guide_confirmed != nil
			flash[:notice] = 'Trip on ' + @order_item.date_range + ' was confirmed.'
		else
			flash[:notice] = 'Failed to confirm. Please try again.'
		end
		redirect_to profile_path(current_user)
	end

	def edit_redirect
		session[:new_attendance] 	= params[:order_item][:number_of_people].to_i
		@new_attendance 			= set_new_attendance
		@old_attendance 			= @order_item.trip_attendance

		if @new_attendance > @old_attendance
			redirect_to confirm_add_participants_path
		elsif @new_attendance == 0
			redirect_to confirm_cancel_trip_path
		elsif @new_attendance < @old_attendance
			redirect_to confirm_cancel_participants_path
		end
	end

	def confirm_add_participants
		@new_oi = OrderItem.new
		@new_charge = @order_item.cost_of_additional(@attendance_difference)
	end

	def confirm_cancel_trip
		@new_attendance = 0
	end

	def confirm_cancel_participants
	end

	def change_confirmation
	end

	def cancel_participants
		@new_oi 					= @order_item.dup
		@new_oi.number_of_people 	= @attendance_difference
		@new_oi.second_person_cost	= @order_item.second_person_refund_amount(@new_attendance)
		@new_oi.first_person_cost	= @order_item.first_person_refund_amount(@new_attendance)

		@order = Order.new
		@order.save!
		@new_oi.order_id = @order.id

		description = "Refunds" + @attendance_difference.to_s + " people on order_item.id: " + @new_oi.id.to_s
		if @new_attendance == 0
			description = description + " ::TRIP CANCELLED"
		end

		@refund = @order_item.refund_total(@new_attendance) * 100
		
		charge = Stripe::Charge.retrieve(@order_item.stripe_charge_id)
		charge.refund(:amount =>  @refund)
		charge.description = description

		respond_to do |format|
			if @new_oi.save!
				UserMailer.order_change_confirmation(current_user, @order_item).delay.deliver
				format.html { redirect_to change_confirmation_path }
				format.json { render action: 'show', status: :created, location: @new_oi }
			else
				format.html { render action: 'confirm_add_participants', notice: "We're sorry, but we were unable to complete this purchase." }
				format.json { render json: @new_oi.errors, status: :unprocessable_entity }
			end
		end
	end


	def add_participants
		@new_oi 					= @order_item.dup
		@description 				= "Adds " + @attendance_difference.to_s + "participants on new order_item.id: " + @new_oi.id.to_s
		@new_oi.number_of_people 	= @attendance_difference
		@new_oi.first_person_cost 	= @new_oi.second_person_cost

		@amount 					= @new_oi.line_total.abs * 100

		# charge the card
		@token 	= params[:stripe_card_token]
		@charge = Stripe::Charge.create(	
			:card 			=> @token,
			:amount 		=> @amount,
			:description 	=> @description,
			:currency 		=> 'usd'
		)

		@new_oi.stripe_charge_id = @charge.id

		@order = Order.new
		@order.save!
		@new_oi.order_id = @order.id

		respond_to do |format|
			if @new_oi.save!
				UserMailer.order_change_confirmation(current_user, @order_item).delay.deliver
				format.html { redirect_to change_confirmation_path }
				format.json { render action: 'show', status: :created, location: @new_oi }
			else
				format.html { render action: 'confirm_add_participants', notice: "We're sorry, but we were unable to complete this purchase." }
				format.json { render json: @new_oi.errors, status: :unprocessable_entity }
			end
		end
	end

private

	def define_attendance_difference
		@original_attendance 		= @order_item.trip_attendance
		@attendance_difference		= @new_attendance - @original_attendance
	end

	def confirm_authorized
		confirm_signed_in
		unless (current_user.id == @order_item.buyer_id or current_user.admin?) then redirect_to cart_path end
	end

	def confirm_user_is_guide
		#confirm_signed_in
		#unless (current_user.guide? || current_user.admin?) then redirect_to home_path end
	end
end
