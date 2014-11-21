class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :hq_address
      t.string :hq_city
      t.string :hq_state
      t.string :country
      t.text :description
      t.string :phone
      t.string :email
      t.integer :owner_id
      t.string :contact_name

      t.timestamps
    end
  end
end
