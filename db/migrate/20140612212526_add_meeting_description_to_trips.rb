class AddMeetingDescriptionToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :meeting_description, :string
  end
end
