class AddShortDescriptionToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :short_description, :text
  end
end
