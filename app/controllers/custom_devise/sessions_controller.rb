class CustomDevise::SessionsController < Devise::SessionsController
  skip_before_filter :store_last_attempted_location
  skip_after_filter  :store_last_successful_location

  def new
    super
  end
  
  def create
    super
  end
  
  def destroy
    super
  end

  protected
  
  def after_sign_in_path_for(resource)
    redirect_back_location_or(home_path)
  end

end