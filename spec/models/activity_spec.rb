# == Schema Information
#
# Table name: activities
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  description       :text
#  created_at        :datetime
#  updated_at        :datetime
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  slug              :string(255)
#  test_column       :string(255)
#

require "spec_helper"

describe Activity do

	it "has a valid factory" do
		expect( FactoryGirl.build :activity ).to be_valid
	end

	it "is invalid without a title" do
		expect( FactoryGirl.build :activity, title: nil ).not_to be_valid
	end

end
