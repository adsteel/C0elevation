class AddServiceTaxRateToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :service_tax_rate, :integer
  end
end
