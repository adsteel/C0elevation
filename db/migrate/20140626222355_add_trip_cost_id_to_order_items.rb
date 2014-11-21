class AddTripCostIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :trip_cost_id, :integer
  end
end
