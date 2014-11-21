# == Schema Information
#
# Table name: requests
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  email                :string(255)
#  message              :text
#  created_at           :datetime
#  updated_at           :datetime
#  user_id              :integer
#  trip_id              :integer
#  requested_attendance :string(255)
#

class Request < ActiveRecord::Base
end
