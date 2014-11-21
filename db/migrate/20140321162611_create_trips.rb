class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :activity_id
      t.integer :guide_id
      t.integer :difficulty_id
      t.integer :location_id
      t.integer :route_id
      t.integer :feature_id
      t.string :latitude
      t.string :longitude
      t.text :required_gear
      t.text :supplied_gear
      t.text :special_directions
      t.integer :offer_capacity
      t.integer :trip_length_id
      t.text :description
      t.text :itinerary

      t.timestamps
    end
  end
end
