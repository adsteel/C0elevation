# == Schema Information
#
# Table name: trip_dates
#
#  id         :integer          not null, primary key
#  trip_id    :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#  start_time :string(255)
#

class TripDate < ActiveRecord::Base
	belongs_to :trip
	has_many :order_items
	has_many :buyers, -> { distinct }, through: :order_items

	validates :trip_id,  	presence: true
	validates :start_date,  presence: true
	validates :start_time,  presence: true

	def date_range
		if start_date == end_date
			start_date.strftime('%-m/%-d/%y') + ", starts at " + start_time
		else
			start_date.strftime('%-m/%-d') + " - " + end_date.strftime('%-m/%-d/%y')
		end
	end

	def date_range_with_weekday
		if start_date == end_date
			start_date.strftime('%a %-m/%-d/%y') + ", starts at " + start_time
		else
			start_date.strftime('%a %-m/%-d') + " - " + end_date.strftime('%a %-m/%-d/%y')
		end
	end

	# def id_with_potential_attendance
	# 	id.to_s + ":" + potential_attendance.to_s
	# end

	def deletable?
		order_items.reject { oi.cancelled? }.length == 0
	end

	def booked?
		if self.order_items.first
			self.order_items.first.booked?
		else
			false
		end
	end

	def potential_attendance
		order_items.length > 0 ? order_items.first.potential_attendance : 0
	end

end
