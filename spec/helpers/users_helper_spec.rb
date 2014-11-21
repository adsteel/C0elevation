require "spec_helper"

describe UsersHelper do
	describe "phone_format()" do
		it "should return a formatted phone number" do
			expect( phone_format "1112223333" ).to include("(111) 222-3333")
		end

		 it "should return digits past 10th as an extension" do
			expect( phone_format "1112223333444" ).to include("ext 444")
		end
	end
end