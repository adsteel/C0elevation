class AddGuideConfirmedToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :guide_confirmed, :datetime
  end
end
