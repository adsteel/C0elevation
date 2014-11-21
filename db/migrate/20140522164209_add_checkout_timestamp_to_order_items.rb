class AddCheckoutTimestampToOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items, :checkout_begin, :datetime
  end
end
