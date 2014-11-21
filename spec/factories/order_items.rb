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

FactoryGirl.define do

    factory :order_item do
        trip
        trip_date
        company
        buyer
        number_of_people    2
        trip_cost
        service_tax_rate    1

        factory :bad_order_item do
        	buyer_id		nil
    	end   
    end

end
