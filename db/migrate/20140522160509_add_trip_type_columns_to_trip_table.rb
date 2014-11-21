class AddTripTypeColumnsToTripTable < ActiveRecord::Migration
  def change
  	add_column :trips, :private, :boolean
  	add_column :trips, :group, :boolean
  	add_column :trips, :class, :boolean
  end
end
