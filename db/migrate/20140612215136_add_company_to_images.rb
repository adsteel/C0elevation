class AddCompanyToImages < ActiveRecord::Migration
  def change
    add_column :images, :company_id, :integer
  end
end
