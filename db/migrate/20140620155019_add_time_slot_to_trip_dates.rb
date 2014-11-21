class AddTimeSlotToTripDates < ActiveRecord::Migration
  def change
    add_column :trip_dates, :time_slot, :string
  end
end
