class AddActiveColumnToTripsCompaniesGuides < ActiveRecord::Migration
  def change
  	add_column :companies, :active, :boolean
  	add_column :trips, :active, :boolean
  	add_column :guides, :active, :boolean
  	add_column :users, :active, :boolean
  end
end
