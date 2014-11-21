class RemoveExtraColumnsFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :feature_id, :integer
    remove_column :images, :route_id, :integer
    remove_column :images, :image_content_type, :string
    remove_column :images, :image_file_size, :string
    remove_column :images, :image_file_name, :string
    remove_column :images, :image_updated_at, :string
  end
end
