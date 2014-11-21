class RemoveCostColumnsFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :first_person_cost, :string
    remove_column :order_items, :second_person_cost, :string
  end
end
