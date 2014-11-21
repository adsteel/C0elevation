class ApplicationController < ActionController::Base
	include ControllersHelper
  protect_from_forgery with: :exception
	layout 'application'
	before_filter 	:configure_permitted_parameters, if: :devise_controller?
	before_filter 	:set_layout_variables, :store_last_attempted_location
	after_filter 	  :store_last_successful_location

protected

	def set_layout_variables
		@activities = Activity.all
    @privacy_policy = RegistrationAgreement.last
    @terms_of_service = ClientAgreement.last
    get_cart_items
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :first, :last, :email, :password, :password_confirmation, :remember_me, :accept_terms) }
		devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :first, :last, :email, :password, :password_confirmation, :current_password) }
	end

	def get_cart_items
		if user_signed_in?
			@cart_items = current_user.cart_items
			@trip_id_array = @cart_items.collect { |i| i.trip_date_id.to_s }
		end
	end
  
  
  # devise redirects
  

  
  # redirect helpers

	def store_last_successful_location
		session[:last_successful_location] = request.fullpath
    session.delete(:last_attempted_location)
	end

	def store_last_attempted_location
		session[:last_attempted_location] = request.fullpath
	end
  
  def redirect_back_location_or(default)
    if session[:last_successful_location]
  		session[:last_successful_location]
    else
      default
    end
  end

	def redirect_back_or(default)
    redirect_to redirect_back_location_or(default)
	end
  
  
  # authentication helpers

	def confirm_signed_in
		unless user_signed_in?
			flash.now[:notice] = 'Please sign in.'
			redirect_to new_user_session_path
		end
	end

	def authenticate_guide
		confirm_signed_in
		redirect_back_or(profile_path(current_user)) unless current_user.guide? || current_user.admin?
	end

	def authenticate_admin
		confirm_signed_in
		redirect_back_or(profile_path(current_user)) unless current_user.admin?
	end
end
