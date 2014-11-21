class RemoveMeetingTimeFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :meeting_time, :string
  end
end
