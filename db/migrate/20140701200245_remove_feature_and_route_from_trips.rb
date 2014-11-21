class RemoveFeatureAndRouteFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :feature_id, :string
    remove_column :trips, :route_id, :string
  end
end
