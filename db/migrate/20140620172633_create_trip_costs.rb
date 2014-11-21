class CreateTripCosts < ActiveRecord::Migration
  def change
    create_table :trip_costs do |t|
      t.integer :trip_id
      t.integer :one
      t.integer :two
      t.integer :three
      t.integer :four
      t.integer :five
      t.integer :six
      t.integer :seven
      t.integer :eight
      t.integer :nine
      t.integer :ten

      t.timestamps
    end
  end
end
