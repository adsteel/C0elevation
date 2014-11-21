class AddPrimaryImageIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :primary_image_id, :integer
  end
end
