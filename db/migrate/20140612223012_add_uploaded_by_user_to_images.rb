class AddUploadedByUserToImages < ActiveRecord::Migration
  def change
    add_column :images, :uploaded_by_user_id, :integer
  end
end
