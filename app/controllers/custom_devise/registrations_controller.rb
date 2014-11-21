class CustomDevise::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :store_last_attempted_location
  skip_after_filter  :store_last_successful_location

  def new
    set_new_variables
    super
  end
  
  def create
    set_new_variables
    super
    resource.update({
      :client_agreement => ClientAgreement.last.uniq_name,
      :registration_agreement => RegistrationAgreement.last.uniq_name
    })
    flash[:notice] = "Thank you for signing up! Check your email account for a confirmation link to complete the process. Be sure to check your spam folder."
  end

  protected

  def set_new_variables
    @policy = RegistrationAgreement.last
    @terms = ClientAgreement.last
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end
  
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end 

end