class AddImageToImages < ActiveRecord::Migration
  def change
  	add_attachment :images, :image
  end
end
