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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip_cost do
    trip
    one 1
  end
end
