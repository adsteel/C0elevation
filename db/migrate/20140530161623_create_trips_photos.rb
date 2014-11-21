class CreateTripsPhotos < ActiveRecord::Migration
  def change
    create_table :trips_photos do |t|
      t.integer :trip_id
      t.integer :company_id
      t.integer :guide_id
      t.integer :activity_id
      t.integer :location_id

      t.timestamps
    end
  end
end
