# == Schema Information
#
# Table name: orders
#
#  id                         :integer          not null, primary key
#  created_at                 :datetime
#  updated_at                 :datetime
#  client_agreement_uniq_name :string(255)
#  stripe_card_token          :string(255)
#

class Order < ActiveRecord::Base
	has_many :order_items, dependent: :destroy
	has_many :order_item_histories

	validates :terms_of_service, acceptance: true#, :message => "Please accept the terms of service."

	def total
		order_items = OrderItems.where("order_id = ?", self.id).all
		total = 0
		order_items.each do |i|
			total = total + i.total 
		end
		return total
	end
end
