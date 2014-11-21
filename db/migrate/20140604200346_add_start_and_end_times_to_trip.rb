class AddStartAndEndTimesToTrip < ActiveRecord::Migration
  def change
  	add_column :trips, :meeting_time, :time
  	add_column :trips, :length_description, :string
  end
end
