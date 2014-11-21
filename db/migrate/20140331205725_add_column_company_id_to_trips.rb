class AddColumnCompanyIdToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :company_id, :integer
  end
end
