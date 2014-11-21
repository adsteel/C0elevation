class AddTitleToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :title, :string
  end
end
