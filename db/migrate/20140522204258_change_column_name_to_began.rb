class ChangeColumnNameToBegan < ActiveRecord::Migration
  def change
  	rename_column :order_items, :checkout_begin, :checkout_began
  end
end
