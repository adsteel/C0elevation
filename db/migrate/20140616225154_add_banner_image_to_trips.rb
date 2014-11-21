class AddBannerImageToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :banner_image_id, :integer
  end
end
