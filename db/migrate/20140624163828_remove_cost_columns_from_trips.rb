class RemoveCostColumnsFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :first_person_cost, :integer
    remove_column :trips, :second_person_cost, :integer
  end
end
