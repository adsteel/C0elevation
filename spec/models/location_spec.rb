# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  description :string(255)
#  latitude    :string(255)
#  longitude   :string(255)
#  agency_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#  slug        :string(255)
#

require "spec_helper"

describe Location do

	it "has a valid factory" do
		expect( FactoryGirl.build :location ).to be_valid
	end

	it "is invalid without a description" do
		expect( FactoryGirl.build :location, description: nil ).not_to be_valid
	end

end
