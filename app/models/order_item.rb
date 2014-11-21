# == Schema Information
#
# Table name: order_items
#
#  id                   :integer          not null, primary key
#  order_id             :integer
#  company_id           :integer
#  trip_id              :integer
#  trip_date_id         :integer
#  number_of_people     :integer
#  created_at           :datetime
#  updated_at           :datetime
#  buyer_id             :integer
#  stripe_charge_id     :string(255)
#  slug                 :string(255)
#  checkout_began       :datetime
#  ganked               :boolean
#  guide_confirmed      :datetime
#  confirmed_by_user_id :integer
#  trip_cost_id         :integer
#  service_tax_rate     :integer
#

class OrderItem < ActiveRecord::Base
	include FriendlyId

	friendly_id :slug_candidates, use: :slugged

	def slug_candidates
		[
			SecureRandom.hex(10),
			SecureRandom.hex(10),
			SecureRandom.hex(10),
		]
	end

	belongs_to :order
	belongs_to :company
	belongs_to :trip
	belongs_to :trip_date
  belongs_to :trip_cost
	belongs_to :client, :class_name => 'User', :foreign_key => :buyer_id
	belongs_to :buyer,  :class_name => 'User', :foreign_key => :buyer_id
	has_one :guide, through: :trip

  validates :trip_id,             presence: :true
  validates :trip_date_id,        presence: :true
  validates :company_id,          presence: :true
  validates :number_of_people,    presence: :true
  validates :buyer_id,            presence: :true
  validates :trip_cost_id,        presence: :true
  validate :allow_proposed_attendance

	delegate 	:guide_full_name,
    				:guide_phone,
    				:guide_first,
    				:guide_last,
    				:guide_rate_percent,
    				:tag_line,
    				:description,
    				:length,
    				:location_description,
    				:difficulty,
    				:activity_title,
    				:company_name,
    				:required_gear,
    				:supplied_gear,
    				:special_directions,
    				:min,
    				:max,
    				:group,
    				:course,
    				:private,
    				:latitude,
    				:longitude,
    				:title,
    				:primary_image,
    				:banner_image,
    				:meeting_description,
    				:one_liner,
    				:short_description,
    				:length_description,
    				to: :trip,
    				:allow_nil => true
				
	delegate 	:email,
    				:phone,
    				:full_name,
    				:full_address,
    				:profile_complete?,
    				:emergency_full_name,
    				:emergency_phone,
    				:emergency_email,
    				:emergency_relationship,
    				:emergency_notes,
    				to: :user,
    				prefix: 'client',
    				:allow_nil => true

	delegate	:date_range,
    				:start_date,
    				:end_date,
    				:start_time,
    				to: :trip_date,
    				:allow_nil => true

	scope :my_expiring_items, 	lambda { |user| select { |e| e.expiring? && e.buyer_id == user.id} }


###   formatting helpers   ###

  def service_tax_rate
  	super.to_f / 100
  end

  def service_tax_rate= new_val
  	super(new_val * 100)
  end

###   cost calculations   ###

	def cost_columns
		TripCost::COSTCOLUMNS
	end

  def current_trip_cost
    trip.trip_costs.last
  end

	def line_total
		total = 0
		cost_columns.each { |col| total = total + trip_cost.send(col) if col.in_numbers.to_i <= number_of_people.to_i }
		return total
	end

	def line_service_tax_total
		line_total * service_tax_rate
	end

	def line_grand_total
		line_total + line_service_tax_total
	end

  
###    checkers    ##
  
	def cancelled?
		purchased_trip_attendance < 1 ? true : false
	end

	def group?
		self.trip.group == true ? true : false
	end

	def course?
		self.trip.course == true ? true : false
	end

	def private?
		self.trip.private == true ? true : false
	end

	def booked?
		not cancelled? and order_id ? true : false
	end

	def expiring?
		checkout_began && checkout_began > ( Time.now - 3400 ) ? true : false
	end

	def available_for_public_purchase?
		if ( group? or course? ) and ( potential_attendance < max )
			true
		elsif private? and not booked? and potential_attendance <= 0 and not ganked?
			true
		else
			false
		end
	end

	###                                 ###
	###     ATTENDANCE CALCULATIONS     ###
	###                                 ###

	def similars
		sames.reject{ |i| i.buyer_id == self.buyer_id }
	end

	def sames
		OrderItem.where('trip_date_id = ?', self.trip_date_id)
	end

	def expiring_trip_attendance
		sames.select { |e| e.expiring? }.sum(&:number_of_people)
	end

	def purchased_trip_attendance
		sames.select { |i| i.order_id != nil }.sum(&:number_of_people)
	end

	def potential_attendance
		purchased_trip_attendance + expiring_trip_attendance 
	end

	def payer_purchased_trip_attendance(payer)
		sames.select { |i| i.order_id != nil && i.buyer_id == payer.id }.sum(&:number_of_people)
	end



	###                             ###
	###      REFUND CALCULATIONS    ###
	###                             ###

	# def refund_total(new_attendance)
	# 	n_a = new_attendance
	# 	o_a = trip_attendance
	# 	diff = n_a - o_a
	# 	amount = 0
	# 	if diff < 0
	# 		amount = first_person_refund_amount(n_a)
	# 		if diff < -1
	# 			amount = amount + second_person_refund_amount(n_a) * (diff - 1)
	# 		end
	# 	end
	# 	return amount.abs
	# end

	# def refund_rate
	# 	window = self.trip_date.start_date - Date.today
	# 	if window > 14
	# 		return 1
	# 	elsif window > 1 
	# 		return 0.5
	# 	else
	# 		return 0
	# 	end
	# end

	# def first_person_refund_amount(new_att)
	# 	old_att = self.trip_attendance
	# 	if new_att == old_att
	# 		self.first_person_cost * refund_rate * -1
	# 	elsif new_att < old_att
	# 		self.second_person_cost * refund_rate * -1
	# 	else
	# 		# invalid entry
	# 	end
	# end

	# def second_person_refund_amount(new_att)
	# 	old_att = self.trip_attendance
	# 	if new_att == old_att
	# 		second_person_cost * refund_rate * -1
	# 	elsif new_att < old_att
	# 		second_person_cost * refund_rate * -1
	# 	else
	# 		# invalid entry
	# 	end
	# end

	def actual_money_spent
		sames.collect { |i| i.line_total }.sum
	end

	def user_purchased_trip_attendance(user)
		purchased_trip_attendance.select { |t| t.buyer_id == user.id }
	end

	def line_paid_to_guide
		line_total * guide_rate
	end

	def total_paid_to_guide
		actual_money_spent * guide_rate
	end

	# def guide_refund_total
	# 	refund_total * guide_rate
	# end

	def trip_refunded
		sames.collect { |i| i.line_total < 0 ? i.line_total : 0 }.sum
	end


	###                             ###
	###      RELATED PEOPLE         ###
	###                             ###


	def buyers
		ids = sames.select(:buyer_id).uniq
		User.find ids
	end

	###      CUSTOM VALIDATIONS    ###

	def allow_proposed_attendance
		( number_of_people > 0 ) && ( number_of_people < ( max - potential_attendance ) )
	end

end
