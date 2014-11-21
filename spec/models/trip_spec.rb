require "spec_helper"

describe Trip do

  before(:each) do
    company = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company)
  end
  
	it "has a valid factory" do
		expect( FactoryGirl.build :trip ).to be_valid
	end

  it "should be invalid without an activity" do
    expect( FactoryGirl.build :trip, activity_id: nil ).not_to be_valid
  end

  it "should be invalid without a guide" do
    expect( FactoryGirl.build :trip, guide_id: nil ).not_to be_valid
  end

  it "should be invalid without a location" do
    expect( FactoryGirl.build :trip, location_id: nil ).not_to be_valid
  end

  it "should be invalid without a description" do
    expect( FactoryGirl.build :trip, description: nil ).not_to be_valid
  end

  it "should be invalid without a difficulty" do
    expect( FactoryGirl.build :trip, difficulty: nil ).not_to be_valid
  end

  it "should be invalid with a difficulty from outside the list" do
    expect( FactoryGirl.build :trip, difficulty: "random" ).not_to be_valid
  end

  it "should be invalid without a length" do
    expect( FactoryGirl.build :trip, length: nil ).not_to be_valid
  end

  it "should be invalid without a length description" do
    expect( FactoryGirl.build :trip, length_description: nil ).not_to be_valid
  end

  it "should be invalid with a length from outside the list" do
    expect( FactoryGirl.build :trip, length: "random" ).not_to be_valid
  end

  it "should be invalid without a company" do
    expect( FactoryGirl.build :trip, company_id: nil ).not_to be_valid
  end

  it "should be invalid without a max number of people" do
    expect( FactoryGirl.build :trip, max: nil ).not_to be_valid
  end

  it "should be invalid without an itinerary" do
    expect( FactoryGirl.build :trip, itinerary: nil ).not_to be_valid
  end

  it "should be invalid without a time_of_year" do
    expect( FactoryGirl.build :trip, time_of_year: nil ).not_to be_valid
  end

  it "should be invalid without a title" do
    expect( FactoryGirl.build :trip, title: nil ).not_to be_valid
  end

  it "should be invalid without at least one trip type" do
    expect( FactoryGirl.build :trip, group: false, private: false, course: false ).not_to be_valid
  end
end
