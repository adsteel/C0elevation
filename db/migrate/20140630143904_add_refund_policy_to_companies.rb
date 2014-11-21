class AddRefundPolicyToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :refund_policy, :text
  end
end
