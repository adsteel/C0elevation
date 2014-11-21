class AddThreeColumnsToTrip < ActiveRecord::Migration
  def change
  	add_column :trips, :min, :integer
  	add_column :trips, :max, :integer
  	add_column :trips, :service_tax, :integer
  end
end
