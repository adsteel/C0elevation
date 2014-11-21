class AddCostToTrip < ActiveRecord::Migration
  def change
  	add_column :trips, :first_person_cost, :integer
  	add_column :trips, :second_person_cost, :integer
  end
end
