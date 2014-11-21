class AddAttachmentToClientAgreements < ActiveRecord::Migration
  def change
  	add_attachment :client_agreements, :pdf
  end
end
