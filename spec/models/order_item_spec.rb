# == Schema Information
#
# Table name: order_items
#
#  id                   :integer          not null, primary key
#  order_id             :integer
#  company_id           :integer
#  trip_id              :integer
#  trip_date_id         :integer
#  number_of_people     :integer
#  created_at           :datetime
#  updated_at           :datetime
#  buyer_id             :integer
#  stripe_charge_id     :string(255)
#  slug                 :string(255)
#  checkout_began       :datetime
#  ganked               :boolean
#  guide_confirmed      :datetime
#  confirmed_by_user_id :integer
#  trip_cost_id         :integer
#  service_tax_rate     :integer
#

require "spec_helper"

describe OrderItem do

  before(:each) do
    company = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company)
  end

	it "has a valid factory" do
		expect( FactoryGirl.build :order_item ).to be_valid
	end
 
	it "is invalid without a company" do
		expect( FactoryGirl.build :order_item, company_id: nil ).not_to be_valid
	end

	it "is invalid without a trip" do
    allow_any_instance_of(OrderItem).to receive(:allow_proposed_attendance).and_return(true)
		expect( FactoryGirl.build :order_item, trip_id: nil ).not_to be_valid
	end

	it "is invalid without a trip date" do
		expect( FactoryGirl.build :order_item, trip_date_id: nil ).not_to be_valid
	end

	it "is invalid without a defined number of people" do
    allow_any_instance_of(OrderItem).to receive(:allow_proposed_attendance).and_return(true)
		expect( FactoryGirl.build :order_item, number_of_people: nil ).not_to be_valid
	end

	it "is invalid without a buyer" do
		expect( FactoryGirl.build :order_item, buyer_id: nil ).not_to be_valid
	end

end
