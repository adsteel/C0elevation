# == Schema Information
#
# Table name: guides
#
#  id                 :integer          not null, primary key
#  user_id            :string(255)
#  intro              :text
#  bio                :string(255)
#  approved           :boolean
#  banned             :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  accept_terms       :boolean
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  active             :boolean
#  slug               :string(255)
#

require 'factory_girl_rails'
require 'date'

FactoryGirl.define do

	factory :guide do
		user
		intro			"I'm a guide"
		bio				"More text here"
		approved		true
		accept_terms	true

		factory :bad_guide do 
			intro nil
		end
	end

end
