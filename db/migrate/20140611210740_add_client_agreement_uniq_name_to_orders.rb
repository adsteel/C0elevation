class AddClientAgreementUniqNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :client_agreement_uniq_name, :string
  end
end
