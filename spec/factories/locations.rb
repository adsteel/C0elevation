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

require 'factory_girl_rails'
require 'date'

FactoryGirl.define do

	factory :location do
		description

		factory :bad_location do 
			description nil
		end
	end

end
