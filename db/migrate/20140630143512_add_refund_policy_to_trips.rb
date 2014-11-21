class AddRefundPolicyToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :refund_policy, :text
  end
end
