class DeviseMailer < Devise::Mailer 
	helper :application
  before_action :get_coelevation
  
	include Devise::Controllers::UrlHelpers

  private
  
    def get_coelevation
      @ce = Company.find_by_id(4)
    end


end