class AddScoopedToOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items, :ganked, :boolean
  end
end
