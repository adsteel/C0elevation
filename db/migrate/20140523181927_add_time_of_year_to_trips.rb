class AddTimeOfYearToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :time_of_year, :string
  end
end
