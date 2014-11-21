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

class Guide < ActiveRecord::Base
	include FriendlyId
	friendly_id :slug_candidates, use: :slugged

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/images/:style/missing.jpg"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	has_many :trips
	has_many :images
	has_many :trip_dates, through: :trips
	has_many :order_items, through: :trips

	belongs_to	:user

	validates :user_id,  presence: true
	validates :intro,  presence: true
  validates_uniqueness_of :user_id

	delegate :email, :full_name, :city,	:state,	to: :user, :prefix => false, 	:allow_nil => true
	delegate :id, :intro, :bio, 				to: :user, :prefix => true, 	:allow_nil => true

	after_initialize :set_defaults

	def set_defaults
		self.active = true if self.active.nil?
	end

	def slug_candidates
		[
			[:full_name],
			[:full_name, :state ],
			[:full_name, :state, rand(10..99)],
			[:full_name, :state, rand(10..99)]
		]
	end

	def unavailable_dates # Returns as an array
		trip_dates.select{ |td| (td.order_items.first.booked? || td.order_items.first.expiring?) if td.order_items.first }
	end

	def available_dates # Returns as a collection proxy
		unavailables = unavailable_dates
		trip_dates.reject{ |td| unavailables.any? { |ua| ((td.start_date..td.end_date).cover? ua[:start_date]) || ((td.start_date..td.end_date).cover? ua[:end_date]) } }
	end
end
