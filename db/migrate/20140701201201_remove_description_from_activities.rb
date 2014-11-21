class RemoveDescriptionFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :description, :string
  end
end
