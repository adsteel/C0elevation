class AddTripIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :trip_id, :integer
  end
end
