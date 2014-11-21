class AddRatioColumnToImages < ActiveRecord::Migration
  def change
    add_column :images, :ratio, :string
  end
end
