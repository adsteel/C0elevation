class DropTableTripsPhotos < ActiveRecord::Migration
  def change
  	drop_table :trips_photos
  end
end
