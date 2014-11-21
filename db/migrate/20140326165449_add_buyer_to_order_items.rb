class AddBuyerToOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items, :buyer_id, :integer
  end
end
