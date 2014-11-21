class RemoveUserIdFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :user_id, :integer
  end
end
