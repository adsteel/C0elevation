require 'spec_helper'

describe ApplicationHelper do
	describe "full_title" do

		describe "when in staging" do
			it "should include the page title" do
				expect(self).to receive(:staging?).and_return(true)
				expect(full_title("help")).to include('help')
			end
		end

		describe "when in production" do
			describe " and not on a local machine" do
				it "should include the base title" do
					Rails.env.stub(:production? => true)
					expect(self).to receive(:staging?).and_return(false)
					expect(self).to receive(:local_machine?).and_return(false)
			  		expect(full_title("help")).to include('coElevation')
				end
			end
			describe "and on a local machine" do
				it "should include the base title" do
					Rails.env.stub(:production? => true)
					expect(self).to receive(:staging?).and_return(false)
					expect(self).to receive(:local_machine?).and_return(true)
			  		expect(full_title("")).to include('Production')
				end
			end
		end

		it "should present the tag line when no options are passed" do
			expect(self).to receive(:staging?).and_return(true)
	  		expect(full_title("")).to include("Connecting you with outdoor guides")
		end
	end
end
