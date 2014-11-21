require "spec_helper"

describe ControllersHelper do
	describe "#staging?" do
	  describe "when in staging" do
		  it "returns true" do
	        self.stub(:request) { OpenStruct.new(original_url: 'staging.coelevation.com') } 
	        expect( self.staging? ).to be_truthy
	      end
	    end
		describe "when not in staging" do
		  it "returns false" do
		    self.stub(:request) { OpenStruct.new(original_url: 'localhost:3000') } 
		    expect(self.staging?).to be_falsey
		  end
		end
	end
end