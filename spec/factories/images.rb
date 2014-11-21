require 'factory_girl_rails'

FactoryGirl.define do

	factory :image do
		description
    asset_file_name   "image"
    ratio             "3x2"
        
    factory :primary_image do
      ratio  "3x2"
    end
    
    factory :banner_image do
      ratio  "3x1"
    end
	end

end