class CustomDevise::UnlocksController < Devise::UnlocksController
  skip_before_filter :store_last_attempted_location
  skip_after_filter  :store_last_successful_location
  
  # GET /resource/unlock/new
  def new
    super
  end

  # POST /resource/unlock
  def create
    super
  end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    super
  end
  
end
