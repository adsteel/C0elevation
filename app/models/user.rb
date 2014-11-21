# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean
#  guide_status           :integer
#  first                  :string(255)
#  last                   :string(255)
#  email                  :string(255)
#  phone                  :string(255)
#  birthday               :date
#  gender                 :string(255)
#  street_address         :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  emergency_first        :string(255)
#  emergency_last         :string(255)
#  emergency_relationship :string(255)
#  emergency_phone        :string(255)
#  emergency_email        :string(255)
#  emergency_notes        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  customer_uri           :string(255)
#  slug                   :string(255)
#  accept_terms           :boolean
#  active                 :boolean
#  registration_agreement :string(255)
#  client_agreement       :string(255)
#

class User < ActiveRecord::Base
	include FriendlyId
	friendly_id :slug_candidates, use: :slugged

	# Include default devise modules. Others available are:
	# :lockable, :timeoutable, :validatable and :omniauthable
	devise	:database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :confirmable

	has_one :guide, :class_name => 'Guide', :foreign_key => 'user_id'
	has_many :companies, :class_name => 'Company', :foreign_key => 'owner_id'
	has_many :trips, through: :guide
	has_many :order_items, :class_name => 'OrderItem', :foreign_key => 'buyer_id'
	has_many :clients, :class_name => 'OrderItem', :foreign_key => 'buyer_id'
	has_many :uploaded_images, :class_name => 'Image', :foreign_key => 'uploaded_by_user_id'

	validates_associated :order_items
	validates_associated :clients

	validates :first, 			    presence: :true
	validates :last, 			      presence: :true
	validates :email,			      presence: :true
	validates :accept_terms,	  presence: :true

	validates_uniqueness_of :email

	before_validation {

		self.first.to_s.strip
		self.last.to_s.strip
		self.email.to_s.strip
		self.phone 				       			= phone_scrub(self.phone.to_s.strip)
		self.street_address.to_s.strip
		self.city.to_s.strip
		self.state.to_s.strip
		self.emergency_first.to_s.strip
		self.emergency_last.to_s.strip
		self.emergency_relationship.to_s.strip
		self.emergency_phone       				= phone_scrub(self.emergency_phone.to_s.strip)
		self.emergency_email.to_s.strip 

	}

	after_initialize :set_defaults

	@blank = " - "

	def set_defaults
		self.active = true if self.active.nil?
	end

	def slug_candidates
		[
			[rand(1000000001..9999999999)],
			[rand(1000000001..9999999999)],
			[rand(1000000001..9999999999)],
			[rand(1000000001..9999999999)],
			[rand(1000000001..9999999999)],
			[rand(1000000001..9999999999)],
		]
	end

#    ORDERING    #

	def cart_items
		self.order_items.select{ |oi| (oi.available_for_public_purchase? or oi.expiring?) and not oi.booked? }
	end

	def expiring_items
		self.order_items.select{ |oi| oi.expiring? }
	end

	def services_total
		cart_items.collect { |i| i.line_total }.sum
	end

	def service_taxes_total
		cart_items.collect { |i| i.line_service_tax_total }.sum
	end

	def order_total
		services_total + service_taxes_total
	end


#    COUNTING TRIPS - PAST AND FUTURE    #

	def all_client_trips
		self.order_items.where("buyer_id = ?", self.id).select("DISTINCT ON (trip_date_id) *").reject{ |oi| oi.cancelled? }.sort_by{|oi| oi.start_date }
	end

	def all_guide_trips
		self.order_items.select("DISTINCT ON (trip_date_id) *").reject{ |oi| oi.cancelled? }.select{ |oi| oi.trip.guide_id == self.id && oi.booked? }.sort_by{|oi| oi.start_date }
	end

	def upcoming_trips(trips)
		trips.reject{ |t| t.start_date < Date.today }
	end

	def past_trips(trips)
		trips.reject{ |t| t.start_date >= Date.today }
	end

	def upcoming_guide_trips
		upcoming_trips(all_guide_trips)
	end

	def past_guide_trips
		past_trips(all_guide_trips)
	end

	def upcoming_client_trips
		upcoming_trips(all_client_trips)
	end

	def past_client_trips
		past_trips(all_client_trips)
	end



###   Contact information & user status methods   ###

	def full_address
		full_address? ? street_address + ", " + city + ", " + state : ""
	end

	def full_name
		first && last ? first + " " + last : "n/a"
	end

	def emergency_full_name
		emergency_first && emergency_last ? emergency_first + " " + emergency_last : "n/a"
	end

	def client?
		self.order_items.all.count > 0 ? true : false
	end

	def guide?
		self.guide && self.guide.approved == true && self.guide.banned != true ? true : false
	end

	def guide_in_waiting?
		self.guide && self.guide.approved == nil ? true : false
	end

	def emergency_contact?
		emergency_first && emergency_last && emergency_phone && emergency_email && emergency_relationship ? true : false
	end

	def full_address?
		street_address and state and city ? true : false
	end

	def profile_complete?
		phone && email && full_address? && emergency_contact?  ? true : false
	end

	def phone_scrub(number)
		number.gsub(/[^0-9]/, "")
	end

	def missing_attributes
		@missing = []
		unless emergency_contact?
			@missing.push("Your complete emergency contact information.")
		end

		unless full_address?
			@missing.push("Your complete address information.")
		end

		if self.phone.blank?
			@missing.push("The best phone number to reach you at.")
		end

		return @missing
	end

end
