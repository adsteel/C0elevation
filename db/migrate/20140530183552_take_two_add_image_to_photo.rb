class TakeTwoAddImageToPhoto < ActiveRecord::Migration
  def change
  	add_attachment :trips_photos, :image
  end
end
