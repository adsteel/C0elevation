# == Schema Information
#
# Table name: orders
#
#  id                         :integer          not null, primary key
#  created_at                 :datetime
#  updated_at                 :datetime
#  client_agreement_uniq_name :string(255)
#  stripe_card_token          :string(255)
#

require 'factory_girl_rails'

FactoryGirl.define do

	factory :order do

	end

end
