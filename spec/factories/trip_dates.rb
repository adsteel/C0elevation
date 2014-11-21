# == Schema Information
#
# Table name: trip_dates
#
#  id         :integer          not null, primary key
#  trip_id    :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#  start_time :string(255)
#

require 'factory_girl_rails'
require 'date'

FactoryGirl.define do

	factory :trip_date do
		trip 
		start_date  	Date.today + 10
		end_date 		Date.today + 10
		start_time 	"14:59:08"

		factory :bad_trip_date do 
			trip_id nil
		end
	end

end
