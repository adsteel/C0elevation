class DenormalizeActivityAndDifficultyInTrips < ActiveRecord::Migration
  def change
  	remove_column :trips, :trip_length_id, :integer
  	remove_column :trips, :difficulty_id, :integer
  	add_column :trips, :length, :string
  	add_column :trips, :difficulty, :string
  end
end
