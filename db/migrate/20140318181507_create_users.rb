class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin
      t.integer :guide_status
      t.string :first
      t.string :last
      t.string :email
      t.string :phone
      t.date :birthday
      t.string :gender
      t.string :street_address
      t.string :city
      t.string :state
      t.string :emergency_first
      t.string :emergency_last
      t.string :emergency_relationship
      t.string :emergency_phone
      t.string :emergency_email
      t.string :emergency_notes

      t.timestamps
    end
  end
end
