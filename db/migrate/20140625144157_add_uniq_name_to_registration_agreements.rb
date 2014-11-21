class AddUniqNameToRegistrationAgreements < ActiveRecord::Migration
  def change
    add_column :registration_agreements, :uniq_name, :string
  end
end
