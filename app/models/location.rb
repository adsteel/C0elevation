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

class Location < ActiveRecord::Base
	include FriendlyId
	friendly_id :description, use: :slugged

	has_many :trips
	has_many :images

	validates :description,  presence: true
	validates_uniqueness_of :description
end
