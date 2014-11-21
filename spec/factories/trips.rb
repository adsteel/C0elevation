# == Schema Information
#
# Table name: trips
#
#  id                  :integer          not null, primary key
#  activity_id         :string(255)
#  guide_id            :integer
#  location_id         :integer
#  latitude            :string(255)
#  longitude           :string(255)
#  required_gear       :text
#  supplied_gear       :text
#  special_directions  :text
#  description         :text
#  itinerary           :text
#  created_at          :datetime
#  updated_at          :datetime
#  company_id          :integer
#  slug                :string(255)
#  length              :string(255)
#  difficulty          :string(255)
#  guide_rate          :integer
#  min                 :integer
#  max                 :integer
#  service_tax         :integer
#  private             :boolean
#  group               :boolean
#  course              :boolean
#  time_of_year        :string(255)
#  meet_address        :string(255)
#  title               :string(255)
#  length_description  :string(255)
#  active              :boolean
#  meeting_description :string(255)
#  primary_image_id    :integer
#  one_liner           :string(255)
#  banner_image_id     :integer
#  short_description   :text
#  skill_level         :string(255)
#  refund_policy       :text
#

require 'factory_girl_rails'
require 'date'


# validates :difficulty,           presence: :true, :inclusion => { in: DIFFICULTIES }
# validates :length,              presence: :true, :inclusion => { in: LENGTHS }
# validates :skill_level,         presence: :true, :inclusion => { in: SKILLS }


FactoryGirl.define do

	factory :trip do
		activity
		guide
		difficulty			     	"easy"
		length			 		      "full day"
		location
		company
		latitude			 	      "44.981165"
		longitude			 	      "-93.279225"
		one_liner				      "one liner"
		short_description		  "short description. real short"
		description
		required_gear			    "text"
		supplied_gear			    "text"
		itinerary			 	      "itinerary"
		private			 		      true
		max			 			        4
		time_of_year			    "time of year"
		title			 		        "title"
		length_description		"length_description"
		active					      true
    refund_policy         "Refund policy"
    skill_level           "any"
    primary_image
    banner_image

        factory :bad_trip do
            length      nil
            activity    nil
        end
	end


end
