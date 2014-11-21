class AddPdfToRegistrationAgreements < ActiveRecord::Migration
  def change
  	add_attachment :registration_agreements, :pdf
  end
end
