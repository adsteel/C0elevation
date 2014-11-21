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

class Trip < ActiveRecord::Base
	include FriendlyId
	friendly_id :slug_candidates, use: :slugged

	belongs_to :activity
	belongs_to :guide
	belongs_to :company
	belongs_to :location

	has_many :trip_dates
	has_many :trips_photos
	has_many  :trip_costs
	has_many :order_items
	has_many :buyers, through: :order_items
	has_many :images
	belongs_to :primary_image, :class_name => 'Image'
	belongs_to :banner_image, :class_name => 'Image'

	DIFFICULTIES = %w[any easy easy-moderate moderate moderate-difficult difficult extremely-difficult]
	LENGTHS = ["less than half of a day", "half of a day", "full day", "long day", "multi day"]
	SKILLS = ["any", "beginner", "beginner-intermediate", "intermediate", "intermediate-advanced", "advanced", "expert"]


	after_initialize :set_defaults

	validates :activity_id, 			  presence: :true
	validates :location_id, 			  presence: :true
	validates :one_liner,				    presence: :true
	validates :short_description,		presence: :true
	validates :description,   			presence: :true
	validates :difficulty,		   		presence: :true, :inclusion => { in: DIFFICULTIES }
	validates :length,				    	presence: :true, :inclusion => { in: LENGTHS }
	validates :length_description,	presence: :true
	validates :company_id, 			   	presence: :true
	validates :max,				 		      presence: :true
	validates :itinerary,		 		    presence: :true
	validates :time_of_year,		   	presence: :true
	validates :title,					      presence: :true
	validates :skill_level, 			  presence: :true, :inclusion => { in: SKILLS }

	validate  :has_guide_if_needed
	validate  :at_least_one_trip_type
	#validate  :address_or_coordinates

	geocoded_by :meet_address
	reverse_geocoded_by :latitude, :longitude,  :address => :meet_address
	after_validation :reverse_geocode, :geocode

	delegate :email, :full_name, :phone, :first, :last, :intro, to: :guide, :prefix => true, :allow_nil => true
	delegate :description, to: :location, :prefix => true, :allow_nil => true
	delegate :title, to: :activity, :prefix => true	, :allow_nil => true
	delegate :name, :description, :country, to: :company, :prefix => true, :allow_nil => true

	def set_defaults
		self.guide_rate ||= 87
		self.service_tax ||= 0
		self.min ||= 1
		self.active = true if self.active.nil?
    self.refund_policy = company.refund_policy if company && (refund_policy.blank? || (refund_policy && refund_policy.strip.length == 0))
	end

###     CHECKERS    ###

	def type
		return "group" if group?
		return "private" if private?
		return "class" if course?
	end

	def deletable?
		order_items.reject{ |oi| oi.cancelled? }.length == 0
	end

###   cost calculations   ###

  def cost_columns
    TripCost::COSTCOLUMNS
  end

  def current_trip_cost
    trip_costs.last
  end

  def services_total(number_of_people = 0, trip_cost = current_trip_cost)
    total = 0
    cost_columns.each { |col| total = total + trip_cost.send(col) if col.in_numbers.to_i <= number_of_people.to_i }
    return total
  end

  def tax_total(number_of_people = 0, trip_cost = current_trip_cost)
    services_total(number_of_people, trip_cost) * service_tax
  end

  def grand_total(number_of_people = 0, trip_cost = current_trip_cost)
    trip_services_total(number_of_people, trip_cost) + trip_tax_total(number_of_people, trip_cost)
  end



###     PICTURES     ###

	def random_picture
		ids = Image.where(:trip_id == self.id).pluck(:id)
		random_id = ids[rand(ids.length)]
		Image.find(random_id)
	end
  
  def primary_image_url(size = nil)
    primary_image.asset.url(size)
  end

  def banner_image_url(size = nil)
    banner_image.asset.url(size)
  end

###    FORMATTING & TEXT HELPERS    ###

	def guide_full_name
		guide.user.full_name 
	end
  
  def last_trip_cost
    trip_costs.last
  end

	def tag_line
		tag_line = self.activity_title.split.map(&:capitalize).join(' ') + " in " + self.location_description.split.map(&:capitalize).join(' ') + " for " + self.length_description.split.map(&:capitalize).join(' ')
		return tag_line.html_safe
	end

	def slug_candidates
		[
			[:length, "--", :location_description, "--", :title],
			[SecureRandom.hex(5), "----", :length, "--", :location_description, "--", :title]
		]
	end
  
  def service_tax
  	super.to_f / 100
  end

  def service_tax= new_val
  	super(new_val * 100)
  end

###    CUSTOM VALIDATIONS    ###

	def at_least_one_trip_type
		if [self.group, self.course, self.private].reject(&:blank?).size == 0
			errors[:base] << ("Please choose at least one type of trip - Group, Private or Course/Class.")
		end
	end

	def address_or_coordinates
		if ([self.latitude, self.longitude].reject(&:blank?).size < 2 ) and ( [self.meet_address].reject(&:blank?).size < 1)
			errors[:base] << ("Please choose enter a meeting location, either as latitude and longitude or an address")
		end
	end

	def has_guide_if_needed
		if (self.private) and self.guide.blank?
			errors[:base] << ("Please select which guide will be leading this trip")
		end
	end

end
