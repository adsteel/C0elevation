class AddStartTimeToTripDates < ActiveRecord::Migration
  def change
    add_column :trip_dates, :start_time, :string
  end
end
