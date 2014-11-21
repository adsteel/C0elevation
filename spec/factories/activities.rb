# == Schema Information
#
# Table name: activities
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  slug              :string(255)
#

require 'factory_girl_rails'
require 'date'

FactoryGirl.define do

	factory :activity do
		title
		factory :bad_activity do
			title	nil
		end
	end

end
