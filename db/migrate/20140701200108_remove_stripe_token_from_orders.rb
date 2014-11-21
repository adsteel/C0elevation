class RemoveStripeTokenFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :stripe_card_token, :string
  end
end
