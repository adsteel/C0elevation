require 'spec_helper'

describe "ClientAgreements", :type => :request do
  
  describe "GET /client_agreements" do
    before(:each) do
      client_agreement  = instance_double(ClientAgreement, pdf_url: "url")
      privacy_policy    = instance_double(RegistrationAgreement, pdf_url: "url")
      
      allow(ClientAgreement).to receive(:last).and_return(client_agreement)
      allow(RegistrationAgreement).to receive(:last).and_return(privacy_policy)
      
      @activities = create(:activity)
      company_default = double(Company, id: 4, refund_policy: 'refund_policy')
      allow(Company).to receive(:find).and_return(company_default)
      @cart_items = create(:order_item, order_id: nil)
    end
  
  
    it "returns success" do
      get admin_client_agreements_path
      expect(response.status).to be(200)
    end
  end
end
