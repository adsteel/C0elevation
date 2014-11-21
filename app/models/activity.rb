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

class Activity < ActiveRecord::Base
	include FriendlyId
	friendly_id :title, use: :slugged

	has_attached_file :icon, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.jpg"

  	has_many :trips
  	has_many :trip_dates, through: :trips
  	has_many :images
  	
  	validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  	validates :title,  presence: true
end
