class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :company_id
      t.integer :trip_id
      t.integer :trip_date_id
      t.integer :number_of_people

      t.timestamps
    end
  end
end
