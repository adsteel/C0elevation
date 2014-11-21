class AddCostToOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items, :first_person_cost, :integer
  	add_column :order_items, :second_person_cost, :integer
  end
end
