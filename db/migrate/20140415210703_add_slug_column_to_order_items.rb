class AddSlugColumnToOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items, :slug, :string
  	add_index :order_items, :slug
  end
end
