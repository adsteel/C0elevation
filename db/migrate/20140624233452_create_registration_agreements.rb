class CreateRegistrationAgreements < ActiveRecord::Migration
  def change
    create_table :registration_agreements do |t|

      t.timestamps
    end
  end
end
