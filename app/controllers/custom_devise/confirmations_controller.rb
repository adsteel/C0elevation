class CustomDevise::ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :store_last_attempted_location
  skip_after_filter  :store_last_successful_location
  
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end

end
