class CreateClientAgreements < ActiveRecord::Migration
  def change
    create_table :client_agreements do |t|
      t.string :uniq_name

      t.timestamps
    end
  end
end
