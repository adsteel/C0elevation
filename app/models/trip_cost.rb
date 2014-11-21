# == Schema Information
#
# Table name: trip_costs
#
#  id         :integer          not null, primary key
#  trip_id    :integer
#  one        :integer
#  two        :integer
#  three      :integer
#  four       :integer
#  five       :integer
#  six        :integer
#  seven      :integer
#  eight      :integer
#  nine       :integer
#  ten        :integer
#  created_at :datetime
#  updated_at :datetime
#

class TripCost < ActiveRecord::Base
	belongs_to :trip 
  has_many :order_items

	validates :trip_id, 		presence: true
	validates :one, 			  presence: true

	COSTCOLUMNS = %w[one two three four five six seven eight nine ten]

end
