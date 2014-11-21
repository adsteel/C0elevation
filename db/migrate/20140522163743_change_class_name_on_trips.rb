class ChangeClassNameOnTrips < ActiveRecord::Migration
  def change
  	rename_column :trips, :class, :course
  end
end
