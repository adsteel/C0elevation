class AddSlugToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :slug, :string
  end
end
