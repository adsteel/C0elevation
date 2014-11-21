class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :activity_id
      t.integer :location_id
      t.integer :feature_id
      t.integer :route_id
      t.integer :client_id
      t.integer :guide_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
