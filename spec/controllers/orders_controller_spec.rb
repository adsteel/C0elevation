require 'spec_helper'

describe OrdersController, :type => :controller do

	before (:each) do
		@user = create(:user)
		sign_in @user
	end

	describe "GET #new" do
		let(:client_agreement) { create(:client_agreement) }
    
		it "renders the :new view" do
			get :new, :current_agreement_id => client_agreement.id
			expect( response ).to render_template :new
		end
	end


  # describe "POST create action" do
  #   let(:client_agreement)     { create(:client_agreement) }
  #   let(:order)         { attributes_for(:order) }
  #
  #   context "given valid attributes" do
  #     it "creates a new record" do
  #       expect{ post :create, {order: order}, {:current_agreement_id => client_agreement.id} }.to change(Trip, :count).by(1)
  #     end
  #   end
  # end

end