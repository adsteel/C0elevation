class AddSlugColumnToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :slug, :string
  	add_index :activities, :slug
  end
end
