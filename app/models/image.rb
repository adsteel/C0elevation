# == Schema Information
#
# Table name: images
#
#  id                  :integer          not null, primary key
#  activity_id         :integer
#  location_id         :integer
#  client_id           :integer
#  guide_id            :integer
#  trip_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#  asset_file_name     :string(255)
#  asset_content_type  :string(255)
#  asset_file_size     :integer
#  asset_updated_at    :datetime
#  company_id          :integer
#  uploaded_by_user_id :integer
#  description         :string(255)
#  ratio               :string(255)
#  dimensions          :string(255)
#

class Image < ActiveRecord::Base
	has_attached_file :asset, 
				:styles => { :medium => "300x300>", :thumb => "100x100>" }, 
				:default_url => "/images/:style/missing.jpg"
				# :path => ":rails_root/public/:class/:id_partition/:style/:basename.:extension",
				# :url => "/:class/:id_partition/:style/:basename.:extension"


	before_save :extract_dimensions
	serialize :dimensions

	validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/
	validates :ratio,	presence: :true
  validates_with AttachmentSizeValidator, :attributes => :asset, :less_than => 1.megabytes

	belongs_to :activity
	belongs_to :location
	belongs_to :route
	belongs_to :guide
	belongs_to :trip
	belongs_to :company
	belongs_to :user_who_uploaded, :class_name => 'User', :foreign_key => 'uploaded_by_user_id'

	has_one :banner_image, :class_name => 'Trip', :foreign_key => 'banner_image_id'
	has_one :primary_image, :class_name => 'Trip', :foreign_key => 'primary_image_id'


	RATIOS = ["3x2", "3x1", "1x1"]

	def primary_image?
		Trip.all.pluck(:primary_image_id).include? self.id
	end

	def banner_image?
		Trip.all.pluck(:banner_image_id).include? self.id
	end

	def deletable?
		!primary_image? and !banner_image?
	end

	def critical_image_for_trip_id
		Trip.where('primary_image_id = ? OR banner_image_id = ?', self.id, self.id).pluck(:id)
	end

	def image?
  		asset_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
	end

private

	# Retrieves dimensions for image assets
	# @note Do this after resize operations to account for auto-orientation.
	def extract_dimensions
	  return unless image?
	  tempfile = asset.queued_for_write[:original]
	  unless tempfile.nil?
	    geometry = Paperclip::Geometry.from_file(tempfile)
	    self.dimensions = [geometry.width.to_i, geometry.height.to_i]
	  end
	end



end
