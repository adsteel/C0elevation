class AddNumberOfPeopleToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :requested_attendance, :string
  end
end
