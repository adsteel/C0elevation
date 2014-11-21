class AddAssetToImages < ActiveRecord::Migration
  def change
  	  	add_attachment :images, :asset
  end
end
