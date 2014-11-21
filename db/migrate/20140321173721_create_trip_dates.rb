class CreateTripDates < ActiveRecord::Migration
  def change
    create_table :trip_dates do |t|
      t.integer :trip_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
