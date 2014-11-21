# == Schema Information
#
# Table name: client_agreements
#
#  id               :integer          not null, primary key
#  uniq_name        :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  pdf_file_name    :string(255)
#  pdf_content_type :string(255)
#  pdf_file_size    :integer
#  pdf_updated_at   :datetime
#

class ClientAgreement < ActiveRecord::Base
	has_attached_file :pdf
	
	validates :uniq_name, presence: true
	
	validates_uniqueness_of :uniq_name
	validates_attachment_content_type :pdf,
      :content_type => [ 'application/pdf' ],
      :message => "only pdf files are allowed"
      
  def pdf_url(size=nil)
    pdf.url(size)
  end
end
