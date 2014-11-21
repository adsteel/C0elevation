class CustomDevise::PasswordsController < Devise::PasswordsController
  skip_before_filter :store_last_attempted_location
  skip_after_filter  :store_last_successful_location
  
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

end
