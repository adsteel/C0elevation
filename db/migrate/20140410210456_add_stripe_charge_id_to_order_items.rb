class AddStripeChargeIdToOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items, :stripe_charge_id, :string
  end
end
