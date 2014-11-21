class RemoveStripeColumnFromOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :stripe_charge_id, :string
  end
end
