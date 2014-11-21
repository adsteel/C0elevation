# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  hq_address        :string(255)
#  hq_city           :string(255)
#  hq_state          :string(255)
#  country           :string(255)
#  description       :text
#  phone             :string(255)
#  email             :string(255)
#  owner_id          :integer
#  contact_name      :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  active            :boolean
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  slug              :string(255)
#  refund_policy     :text
#

require "spec_helper"

describe Company do
  
  before(:each) do
    company = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company)
  end
  
	it "has a valid factory" do
		expect( FactoryGirl.build :company ).to be_valid
	end

end
