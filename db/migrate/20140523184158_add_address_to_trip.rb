class AddAddressToTrip < ActiveRecord::Migration
  def change
  	add_column :trips, :meet_address, :string
  end
end
