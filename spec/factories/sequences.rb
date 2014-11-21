require 'factory_girl_rails'

FactoryGirl.define do
	sequence(:first) 		    { |n| "First #{n}" }
	sequence(:last) 		    { |n| "Last #{n}" }
	sequence(:email)		    { |n| "Example#{n}email@gmail.com" }
	sequence(:name)  		    { |n| "Example Company #{n}" }
	sequence(:title) 		    { |n| "Title #{n}" }
	sequence(:description)  { |n| "Description #{n}" }
end