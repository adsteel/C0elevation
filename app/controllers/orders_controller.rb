class OrdersController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	before_action :confirm_signed_in
	before_action :authenticate_admin, only: [:index, :destroy, :edit, :update]

	def index
		@orders = Order.all
	end

	def show
		@order_items = OrderItem.where("order_id = ?", @order.id)
	end

	def new
		@order = Order.new
		@agreement = ClientAgreement.last
		session[:current_agreement_id] = @agreement.id
		@cart_items.each { |i| i.update(checkout_began: Time.now) }
	end

	def edit
	end

	def create
		@order 	= Order.new(order_params)
		@agreement = ClientAgreement.find_by_id(session[:current_agreement_id])
		@order.client_agreement_uniq_name = @agreement.uniq_name
		@items 	= current_user.expiring_items
		@descr 	= "IDs of order items: " + @items.collect{ |i| i.id.to_s }.join(', ')
		@total 	= (current_user.order_total * 100).to_i
		@token 	= params[:stripe_card_token]

		# charge the card or raise an error
		begin
			@charge = Stripe::Charge.create(	
				:card 			=> @token,
				:amount 		=> @total,
				:description 	=> @descr,
				:currency 		=> 'usd'
			)
		rescue Stripe::CardError => e
			flash[:alert] = "We're sorry. This card has been declined. Please check card details. "
  		logger.debug "STRIPE DID NOT WORK CORRECTLY. Stripe error message: " + e.json_body[:error][:message] + ", Error code: " + e.json_body[:error][:code]
    end

		if @order.save && @charge.present?
			@items.each do |i|
				i[:order_id] 			= @order.id
				i[:stripe_charge_id] 	= @charge.id
				if i.save!
					i.similars.each { |s| s.update(ganked: true) }
				end
			end
			UserMailer.purchase_confirmation(current_user, @order).deliver
			redirect_to order_confirmation_path
		else
			redirect_to new_order_path
		end
	end


	def update

		respond_to do |format|
			if ch.save
				UserMailer.order_update_confirmation(current_user, @order).delay.deliver
				format.html { redirect_to order_update_confirmation_path, notice: 'Order was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end


	def destroy
		@order.destroy
		respond_to do |format|
			format.html { redirect_to home_path }
			format.json { head :no_content }
		end
	end

	def confirmation
		@order = OrderItem.where('buyer_id = ?', current_user.id).last.order
		#@order_items = OrderItem.where('order_id =?', @order.id)
	end

	def update_confirmaiton
	end

	private
		def set_order
			@order = Order.find(params[:id])
		end

		def order_params
			params.fetch(:order, {}).permit( 
				:stripe_card_token
			)
		end


end
