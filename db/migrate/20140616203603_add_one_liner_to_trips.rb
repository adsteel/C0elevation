class AddOneLinerToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :one_liner, :string
  end
end
