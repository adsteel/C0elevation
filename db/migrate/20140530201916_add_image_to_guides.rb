class AddImageToGuides < ActiveRecord::Migration
  def change
  	add_attachment :guides, :image
  end
end
