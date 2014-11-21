# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  hq_address        :string(255)
#  hq_city           :string(255)
#  hq_state          :string(255)
#  country           :string(255)
#  description       :text
#  phone             :string(255)
#  email             :string(255)
#  owner_id          :integer
#  contact_name      :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  active            :boolean
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  slug              :string(255)
#  refund_policy     :text
#

class Company < ActiveRecord::Base
	include FriendlyId
	friendly_id :name, use: :slugged

	has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/images/:style/missing.jpg"
	
	has_many :order_items
	has_many :images
	has_many :trips, :class_name => 'Trip', :foreign_key => 'company_id'
	belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'

	validates :name, 			presence: :true
	# validates :hq_address, 		presence: :true
	# validates :hq_city, 		presence: :true
	# validates :hq_state, 		presence: :true
	# validates :country, 		presence: :true
	validates :description,		presence: :true
	validates :owner_id, 		presence: :true
	# validates :email, 			presence: :true
	# validates :phone,			presence: :true
	validates :contact_name,	presence: :true

	validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
	validates_uniqueness_of :name

	delegate :full_name, :first, :last, to: :owner, :prefix => true, :allow_nil => true

	before_validation {
		self.email.to_s.strip
		self.phone 				       			= phone_scrub(self.phone.to_s.strip)
		self.hq_address.to_s.strip
		self.hq_city.to_s.strip
		self.hq_state.to_s.strip
	}

	after_initialize :set_defaults

	def set_defaults
		self.active = true if self.active.nil?
    self.refund_policy = default_refund_policy if refund_policy.blank? || (refund_policy && refund_policy.strip.length == 0)
	end
  
  def default_refund_policy
    Company.find(4).refund_policy
  end

	def phone_scrub(number)
		number.gsub(/[^0-9]/, "")
	end
  
  def logo_url(size = nil)
    logo.url(size)
  end
  
end
