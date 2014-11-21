class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :description
      t.string :latitude
      t.string :longitude
      t.integer :agency_id

      t.timestamps
    end
  end
end
