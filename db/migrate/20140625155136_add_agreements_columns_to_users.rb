class AddAgreementsColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registration_agreement, :string
    add_column :users, :client_agreement, :string
  end
end
