class RemoveTimeSlotFromTripDates < ActiveRecord::Migration
  def change
    remove_column :trip_dates, :time_slot, :string
  end
end
