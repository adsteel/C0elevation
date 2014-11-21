class AddConfirmedByColumnToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :confirmed_by_user_id, :integer
  end
end
