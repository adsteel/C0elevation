class AddSkillLevelToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :skill_level, :string
  end
end
