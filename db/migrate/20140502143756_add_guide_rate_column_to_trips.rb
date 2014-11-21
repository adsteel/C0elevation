class AddGuideRateColumnToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :guide_rate, :integer
  end
end
